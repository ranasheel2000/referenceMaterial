Ansible does not require agent on different target machines to operate.
It uses ssh connection to connect with target machines and execute its operations.

Inventory file stores information of different target machines and related information.
It lists down all servers one by one or can list different servers in different groups as well.
```
server1.domain.com
server2.domain.com
server3.domain.com
```

or

```
fe server1.domain.com
be server2.domain.com
db server3.domain.com

[frontend]
fe
[backend]
be
[database]
db
```
or

```
frontend ansible_host=server1.domain.com ansible_connection=ssh ansible_port=22/4444 ansible_user=root ansible_ssh_pass=root
backend ansible_host=server2.domain.com ansible_connection=ssh ansible_port=22/4444 ansible_user=root ansible_ssh_pass=root
database ansible_host=server3.domain.com ansible_connection=ssh ansible_port=22/4444 ansible_user=root ansible_ssh_pass=root

   - for windows use "ansible_connection=winrm"
   - for localhost use "ansible_connection=localhost"
```

default inventory file - **/etc/ansible/hosts**


To check connections with all hosts/servers mentioned in inventory.txt, run following command:  
**ansible -i inventory.txt -m ping**  
&nbsp;  Need to connect with all hosts manually using ssh and accept "add ssh key fingerprint for hosts" during prompt before trying ansible ping commmand  
&nbsp;  or make change in /etc/ansible/ansible.cfg ->  "host_key_checking=False"
  
 


```
# Sample Inventory File

# Web Servers
web_node1 ansible_host=web01.xyz.com ansible_connection=winrm ansible_user=administrator ansible_password=Win$Pass
web_node2 ansible_host=web02.xyz.com ansible_connection=winrm ansible_user=administrator ansible_password=Win$Pass
web_node3 ansible_host=web03.xyz.com ansible_connection=winrm ansible_user=administrator ansible_password=Win$Pass

# DB Servers
sql_db1 ansible_host=sql01.xyz.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Lin$Pass
sql_db2 ansible_host=sql02.xyz.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Lin$Pass
# Groups
[db_nodes]
sql_db1
sql_db2

[web_nodes]
web_node1
web_node2
web_node3

[boston_node]
sql_db1
web_node1

[dallas_node]
sql_db2
web_node2
web_node3

[us_nodes:children]
boston_node
dallas_node
```

