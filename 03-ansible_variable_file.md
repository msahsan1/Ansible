<pre>
<h2> Register to use variable value </h2>

mahsan@vmmint:~/Ansible$ cat 02-playbook.yml 
---
- hosts: dev
  tasks:
    - name: Execute Shell Commands
      shell: uname -r
      register: uname_result
    - debug: msg="{{ uname_result.stdout }}"
mahsan@vmmint:~/Ansible$ ansible-playbook 02-playbook.yml 

PLAY [dev] ***********************************************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************************
ok: [3.145.59.98]
ok: [3.136.20.35]
ok: [3.128.31.109]

TASK [Execute Shell Commands] ****************************************************************************************************************************************************************************
changed: [3.145.59.98]
changed: [3.136.20.35]
changed: [3.128.31.109]

TASK [debug] *********************************************************************************************************************************************************************************************
ok: [3.145.59.98] => {
    "msg": "6.1.49-70.116.amzn2023.x86_64"
}
ok: [3.128.31.109] => {
    "msg": "6.1.49-70.116.amzn2023.x86_64"
}
ok: [3.136.20.35] => {
    "msg": "6.1.49-70.116.amzn2023.x86_64"
}

PLAY RECAP ***********************************************************************************************************************************************************************************************
3.128.31.109               : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
3.136.20.35                : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
3.145.59.98                : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

mahsan@vmmint:~/Ansible$ 

<h2> Use variable files for variable </h2>


ahsan@vmmint:~/Ansible$ cat 03-ansible_variable.yml 
---
- hosts: dev
  vars_files:
    - variables.yml
  vars:
    variable1: "PlayBookValue"
    variable2: "PlayBookValue"
  tasks:
    - name: Variable Value
      debug: msg="Value is {{ variable1 }}"
    
    - name: Variable Value
      debug: msg="Value is {{ variable2 }}"
mahsan@vmmint:~/Ansible$ cat variables.yml 
variable1: "Variables YAML Value"
variable2: "Variables JSON  Value"
mahsan@vmmint:~/Ansible$ ansible-playbook 03-ansible_variable.yml 

PLAY [dev] ***********************************************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************************
ok: [3.145.59.98]
ok: [3.136.20.35]
ok: [3.128.31.109]

TASK [Variable Value] ************************************************************************************************************************************************************************************
ok: [3.128.31.109] => {
    "msg": "Value is Variables YAML Value"
}
ok: [3.145.59.98] => {
    "msg": "Value is Variables YAML Value"
}
ok: [3.136.20.35] => {
    "msg": "Value is Variables YAML Value"
}

TASK [Variable Value] ************************************************************************************************************************************************************************************
ok: [3.145.59.98] => {
    "msg": "Value is Variables JSON  Value"
}
ok: [3.128.31.109] => {
    "msg": "Value is Variables JSON  Value"
}
ok: [3.136.20.35] => {
    "msg": "Value is Variables JSON  Value"
}

PLAY RECAP ***********************************************************************************************************************************************************************************************
3.128.31.109               : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
3.136.20.35                : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
3.145.59.98                : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   





</pre>

