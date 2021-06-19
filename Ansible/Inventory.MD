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
[frontend]
server1.domain.com

[backend]
server2.domain.com

[db]
server3.domain.com
```
or

```
frontend ansible_host=server1.domain.com ansible_connection=ssh ansible_port=22/4444 ansible_user=root ansible_ssh_pass=root
backend ansible_host=server2.domain.com ansible_connection=ssh ansible_port=22/4444 ansible_user=root ansible_ssh_pass=root
db ansible_host=server3.domain.com ansible_connection=ssh ansible_port=22/4444 ansible_user=root ansible_ssh_pass=root

   - for windows use "ansible_connection=winrm"
   - for localhost use "ansible_connection=localhost"
```

default inventory file - **/etc/ansible/hosts**


