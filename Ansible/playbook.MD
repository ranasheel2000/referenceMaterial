Playbook contains details of a play whereas play refers to task or set of different tasks.

Ex of playbook
```
name: playbook-test
host: localhost         <----- this host entry must be present in inventory file
tasks:
    - name: "description of task"
      command: ls       <------ command is a module which executes command specified in its value field.

    - name: "description of task"
      script: test.py   <------ script is a module which executes script specified in its value field.

    - name: "description of task"
      service:          <------ service is a module which starts/stops services as per specified configurations in its value field.
          name: httpd   <------ name of the service to be started.
          state: started    <---- expected state of httpd service, if already in started state, then this step will not be executed.

    - name: "description of task"
      yum:          <------ yum is a module which install/uninstalls certain service/application/rpm etc.
          name: haproxy
          state: present     <---- expected state of haproxy, if already present then this step will not be executed.
```
*There are a lot of other modules available, you can check them by using either ansible official URL or by "ansible-doc -l"*
