This 10minutes tutorial will create 3 VMs: master, worker1, worker2
- Each VM with 2 network interfaces.
- Each VMs with external network access (provided your host machine has internet access and default routes are configured on host machine)
- Each VM ping-able from each other.

**1. Define Network Configurations on Host/Base Machine.**
We will attach 2 interfaces to all of our KVM VMs:
For K8S- cluster Internal Network (Node to Node Communication)
For K8S-External Network (For internet Access)

*1st Linux network.*
```
# cat sh-network.xml
<network>
<name>sh-network</name>
<forward mode=’nat’/>
<bridge name=’virbr154' stp=’on’ delay=’0'/>
<dns>
<forwarder addr=’192.168.154.195'/>
</dns>
<ip address=’192.168.154.1' netmask=’255.255.255.0'>
<dhcp>
<range start=’192.168.154.154' end=’192.168.154.254'/>
</dhcp>
</ip>
</network>
```
*2nd Linux network.*
```
# cat sh1-network.xml
<network>
<name>sh1-network</name>
<forward mode=’nat’/>
<bridge name=’virbr155' stp=’on’ delay=’0'/>
<dns>
<forwarder addr=’192.168.155.195'/>
</dns>
<ip address=’192.168.155.1' netmask=’255.255.255.0'>
<dhcp>
<range start=’192.168.155.154' end=’192.168.155.254'/>
</dhcp>
</ip>
</network>
* I used "NAT" here for both networks for simplicity, 
- one can use "isolated" for internal network and "routed" for External Network.
```

**2. Create Networks**
```
# sudo virsh net-define sh-network.xml
# sudo virsh net-define sh1-network.xml
```

**3. Start Networks**
```
# sudo virsh net-autostart sh-network
# sudo virsh net-start sh-network
# sudo virsh net-autostart sh1-network
# sudo virsh net-start sh1-network\
# sudo virsh net-list — all

```
*List Networks*:
```
# sudo virsh net-list --all
 Name                 State      Autostart     Persistent
----------------------------------------------------------
 sh-network           active     yes           yes
 sh-network1          active     yes           yes
```

**4. Create kickstart files for each VM**
```
$cat master1.cfg
autopart --type=lvm
# Partition clearing information
clearpart --none --initlabel
# Use text install
text
# Use CDROM installation media
cdrom
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8
# Do not configure the X Window System
skipx
# System services
services --disabled="chronyd"
# System timezone
timezone Asia/Kolkata --isUtc --nontp
#Root password
rootpw root
#Initial user
user --name "sheel"  --password root
# Network Configuration
# For DHCP based IP assignment
#network  --bootproto=dhcp --device=ens3 --noipv6 --activate --onboot=off #or --onboot=on
# For STATIC IP assignment
#network  --bootproto=static --device=ens3 --ip=192.168.154.196 --gateway=192.168.154.1 
#                       --netmask=255.255.255.0 --nameserver=8.8.8.8 --activate --noipv6   
                         #Here --noipv6/--noipv4 disables ipv6 or ipv4
#network  --hostname=sheel.domain.com
# 1st interface with default route:
# DEFROUTE is yes by default, but if gateway is not provided, 
# default route will not be created. Add --gatway for defroute on 
# this interface.
network  --bootproto=static --device=ens3 --ip=192.168.154.195 --netmask=255.255.255.0 --gateway=192.168.154.1 --nameserver=8.8.8.8 --activate
# 2nd Interface, without defroute (--nodefroute)
network  --bootproto=static --device=ens4 --ip=192.168.155.195 --netmask=255.255.255.0  --nameserver=8.8.8.8 --activate --nodefroute
#set hostname
network  --hostname=master1.sheel.com
#To add specific routes use post section
#%post
#cat > /etc/sysconfig/network-scripts/route-eth0 <<EOF
#default via 192.168.154.1 dev ens3
#EOF
# Accept Eula
eula --agreed
# Reboot when the install is finished.
reboot
# Packages to be installed during OS Installation, ex: curl.
%packages
curl
%end
# Running subscription-manager as a Post-Install Script
#%post --log=/root/ks-post.log
#/usr/sbin/subscription-manager register --username=sheel@rana.com --password=secret --serverurl=sheel-serverurl.rana.com
#--org="Admin Group" --environment="Dev" --servicelevel=standard --release="8.0"
#%end
For each VM , create different kickstart files.
master1.cfg
network  --bootproto=static --device=ens3 --ip=192.168.154.195 --netmask=255.255.255.0 --gateway=192.168.154.1 --nameserver=8.8.8.8 --activate
# 2nd Interface, without defroute (--nodefroute)
network  --bootproto=static --device=ens4 --ip=192.168.155.195 --netmask=255.255.255.0  --nameserver=8.8.8.8 --activate --nodefroute
#set hostname
network  --hostname=master1.sheel.com
worker1.cfg
network  --bootproto=static --device=ens3 --ip=192.168.154.196 --netmask=255.255.255.0 --gateway=192.168.154.1 --nameserver=8.8.8.8 --activate
# 2nd Interface, without defroute (--nodefroute)
network  --bootproto=static --device=ens4 --ip=192.168.155.196 --netmask=255.255.255.0  --nameserver=8.8.8.8 --activate --nodefroute
#set hostname
network  --hostname=worker1.sheel.com
worker2.cfg
network  --bootproto=static --device=ens3 --ip=192.168.154.197 --netmask=255.255.255.0 --gateway=192.168.154.1 --nameserver=8.8.8.8 --activate
# 2nd Interface, without defroute (--nodefroute)
network  --bootproto=static --device=ens4 --ip=192.168.155.197 --netmask=255.255.255.0  --nameserver=8.8.8.8 --activate --nodefroute
#set hostname
network  --hostname=worker2.sheel.com
```

**5. Place kickstart file and OS image**.

Copy kickstart file and OS image to /tmp/ directory.
(Any location accessible by qemu user.)

```
#cp CentOS-8.2.2004-x86_64-minimal.iso /tmp/CentOS-8.2.2004-x86_64-minimal.iso
#cp master1.cfg /tmp/master1.cfg
```

**6. launch VMs**

*Master VM:*
```
sudo virt-install — name sh-master1 — memory 4096 — vcpus 2 — disk size=15 — location /tmp/CentOS-8.2.2004-x86_64-minimal.iso — os-variant rhel8.0 — network bridge=virbr154,model=virtio — network bridge=virbr155,model=virtio — graphics none — initrd-inject /tmp/master1.cfg — extra-args=”ks=file:/master1.cfg console=tty0 console=ttyS0,115200n8"
```
Worker1 VM:
```
sudo virt-install — name sh-worker1 — memory 8192 — vcpus 2 — disk size=15 — location /tmp/CentOS-8.2.2004-x86_64-minimal.iso — os-variant rhel8.0 — network bridge=virbr154,model=virtio — network bridge=virbr155,model=virtio — graphics none — initrd-inject /tmp/master1.cfg — extra-args=”ks=file:/worker1.cfg console=tty0 console=ttyS0,115200n8"
```
Worker2 VM:
```
sudo virt-install — name sh-worker2 — memory 8192 — vcpus 2 — disk size=15 — location /tmp/CentOS-8.2.2004-x86_64-minimal.iso — os-variant rhel8.0 — network bridge=virbr154,model=virtio — network bridge=virbr155,model=virtio — graphics none — initrd-inject /tmp/master1.cfg — extra-args=”ks=file:/worker2.cfg console=tty0 console=ttyS0,115200n8"
```

*Refer other network related information stored in corresponding kickstart files*
- master1.cfg
- worker1.cfg
- worker2.cfg


**7. Login to VM.**
check kickstart config files for respective root or user login passwords, e.g. master1.cfg.
- If you want to login in continuation of installation process:
```
master login: root
Password:
[root@master1 ~]#
```

- Otherwise just press ctrl+] after completion of installation and login using normal ssh login command:
```
# ssh root@192.168.154.195
root@192.168.155.195's password:         
                     {enter password specified in kickstart file}
#
```

*('ctrl+]' is escape character to escape out of installation prompt, pressing 'ctrl+]' during installation may stop installation.)*


**8. Network Confirmation:**
```
[root@master1 ~]# ip a s
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
inet 127.0.0.1/8 scope host lo
valid_lft forever preferred_lft forever
inet6 ::1/128 scope host
valid_lft forever preferred_lft forever
2: ens3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
link/ether 55:54:03:72:63:2a brd ff:ff:ff:ff:ff:ff
inet 192.168.154.195/24 brd 192.168.154.255 scope global noprefixroute ens3
valid_lft forever preferred_lft forever
inet6 fe80::f028:b131:74c:2804/64 scope link noprefixroute
valid_lft forever preferred_lft forever
3: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
link/ether 59:54:08:ba:56:1a brd ff:ff:ff:ff:ff:ff
inet 192.168.155.195/24 brd 192.168.155.255 scope global noprefixroute ens4
valid_lft forever preferred_lft forever
inet6 fe80::456e:ecf6:3044:7b47/64 scope link noprefixroute
valid_lft forever preferred_lft forever
```

```
[root@master1 ~]# ip r s
default via 192.168.154.1 dev ens3 proto static metric 100
192.168.154.0/24 dev ens3 proto kernel scope link src 192.168.154.195 metric 100
192.168.155.0/24 dev ens4 proto kernel scope link src 192.168.155.195 metric 101
[root@master1 ~]#
```

```
[root@master1 ~]# cat /etc/resolv.conf
# Generated by NetworkManager
search sheel.com
nameserver 8.8.8.8
[root@master1 ~]#
```

```
[root@master1 ~]#ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=114 time=3.27 ms
— — 8.8.8.8 ping statistics — -
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 3.274/3.274/3.274/0.000 ms
[root@master1 ~]#
```


All Set now.
Enjoy!!
