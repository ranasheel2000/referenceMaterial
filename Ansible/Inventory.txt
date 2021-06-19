Ansible does not require agent on different target machines to operate.
It uses ssh connection to connect with target machines and execute its operations.

Inventory file stores information of different target machines and related information.
It lists down all servers one by one or can list different servers in different groups as well.
```
server1
server2
'''
or

```
[frontend]
server2
server3
[backend]
server4
server5
```

default inventory file - /etc/ansible/hosts


