<pre>
<h1> Ansible </h1>

ahsan@vmmint:~/Ansible$ tree
.
├── ansible.cfg
├── ansible_hosts
├── main.tf
├── README.md
├── terraform-key.pem
└── terraform.tfstate

0 directories, 6 files
mahsan@vmmint:~/Ansible$ cat ansible.cfg 
[defaults]
inventory=./ansible_hosts
#inventory=inventory/01_aws_ec2.yml
remote_user=ec2-user
private_key_file=terraform-key.pem
host_key_checking=False
retry_files_enabled=False
mahsan@vmmint:~/Ansible$ cat ansible_hosts 
3.21.12.150
18.116.52.212
18.217.80.114


ahsan@vmmint:~/Ansible$ ansible --version
ansible 2.10.8
  config file = /home/mahsan/Ansible/ansible.cfg
  configured module search path = ['/home/mahsan/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.10.12 (main, Jun 11 2023, 05:26:28) [GCC 11.4.0]
mahsan@vmmint:~/Ansible$ 


ahsan@vmmint:~/Ansible$ ansible -m ping all
[WARNING]: Platform linux on host 3.21.12.150 is using the discovered Python interpreter at /usr/bin/python, but future installation of another Python interpreter could change the meaning of that path.
See https://docs.ansible.com/ansible/2.10/reference_appendices/interpreter_discovery.html for more information.
3.21.12.150 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
[WARNING]: Platform linux on host 18.217.80.114 is using the discovered Python interpreter at /usr/bin/python, but future installation of another Python interpreter could change the meaning of that
path. See https://docs.ansible.com/ansible/2.10/reference_appendices/interpreter_discovery.html for more information.
18.217.80.114 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
[WARNING]: Platform linux on host 18.116.52.212 is using the discovered Python interpreter at /usr/bin/python, but future installation of another Python interpreter could change the meaning of that
path. See https://docs.ansible.com/ansible/2.10/reference_appendices/interpreter_discovery.html for more information.
18.116.52.212 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
mahsan@vmmint:~/Ansible$ 

mahsan@vmmint:~/Ansible$ ansible all -a "uname"
[WARNING]: Platform linux on host 18.116.52.212 is using the discovered Python interpreter at /usr/bin/python, but future installation of another Python interpreter could change the meaning of that
path. See https://docs.ansible.com/ansible/2.10/reference_appendices/interpreter_discovery.html for more information.
18.116.52.212 | CHANGED | rc=0 >>
Linux
[WARNING]: Platform linux on host 3.21.12.150 is using the discovered Python interpreter at /usr/bin/python, but future installation of another Python interpreter could change the meaning of that path.
See https://docs.ansible.com/ansible/2.10/reference_appendices/interpreter_discovery.html for more information.
3.21.12.150 | CHANGED | rc=0 >>
Linux
[WARNING]: Platform linux on host 18.217.80.114 is using the discovered Python interpreter at /usr/bin/python, but future installation of another Python interpreter could change the meaning of that
path. See https://docs.ansible.com/ansible/2.10/reference_appendices/interpreter_discovery.html for more information.
18.217.80.114 | CHANGED | rc=0 >>
Linux
mahsan@vmmint:~/Ansible$ 
<b> after adding interpreter_python=auto_silent </b>

mahsan@vmmint:~/Ansible$ cat ansible.cfg 
[defaults]
inventory=./ansible_hosts
#inventory=inventory/01_aws_ec2.yml
remote_user=ec2-user
private_key_file=terraform-key.pem
host_key_checking=False
retry_files_enabled=False
interpreter_python=auto_silent



mahsan@vmmint:~/Ansible$ ansible all -a "uname"
3.21.12.150 | CHANGED | rc=0 >>
Linux
18.116.52.212 | CHANGED | rc=0 >>
Linux
18.217.80.114 | CHANGED | rc=0 >>
Linux
mahsan@vmmint:~/Ansible$ 

mahsan@vmmint:~/Ansible$ ansible --list-hosts all
  hosts (3):
    3.21.12.150
    18.116.52.212
    18.217.80.114
mahsan@vmmint:~/Ansible$ ansible --list-hosts dev
  hosts (3):
    3.21.12.150
    18.116.52.212
    18.217.80.114
mahsan@vmmint:~/Ansible$ cat ansible_hosts 
[dev]
3.21.12.150
18.116.52.212
18.217.80.114
mahsan@vmmint:~/Ansible$ 

mahsan@vmmint:~/Ansible$ cat 01-ping.yml 
---
- hosts: all
  tasks:
    - name: Ping All Servers
      action: ping
    - debug: msg="Hello"
mahsan@vmmint:~/Ansible$ 


ahsan@vmmint:~/Ansible$ ansible-playbook 01-ping.yml 




PLAY [all] ***********************************************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************************
ok: [18.217.80.114]
ok: [18.116.52.212]
ok: [3.21.12.150]

TASK [Ping All Servers] **********************************************************************************************************************************************************************************
ok: [18.116.52.212]
ok: [18.217.80.114]
ok: [3.21.12.150]

TASK [debug] *********************************************************************************************************************************************************************************************
ok: [3.21.12.150] => {
    "msg": "Hello"
}
ok: [18.116.52.212] => {
    "msg": "Hello"
}
ok: [18.217.80.114] => {
    "msg": "Hello"
}

PLAY RECAP ***********************************************************************************************************************************************************************************************
18.116.52.212              : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
18.217.80.114              : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
3.21.12.150                : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

mahsan@vmmint:~/Ansible$ 




</pre>
