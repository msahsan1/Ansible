<pre>
<h2> EC2 Dynamic Inventory </h2>

ahsan@vmmint:~/Ansible/playbooks$ pip install boto3
Defaulting to user installation because normal site-packages is not writeable
Collecting boto3
  Downloading boto3-1.28.84-py3-none-any.whl (135 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 135.8/135.8 KB 2.9 MB/s eta 0:00:00
Requirement already satisfied: jmespath<2.0.0,>=0.7.1 in /usr/lib/python3/dist-packages (from boto3) (0.10.0)
Collecting s3transfer<0.8.0,>=0.7.0
  Downloading s3transfer-0.7.0-py3-none-any.whl (79 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 79.8/79.8 KB 10.5 MB/s eta 0:00:00
Collecting botocore<1.32.0,>=1.31.84
  Downloading botocore-1.31.84-py3-none-any.whl (11.3 MB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 11.3/11.3 MB 10.3 MB/s eta 0:00:00
Collecting python-dateutil<3.0.0,>=2.1
  Downloading python_dateutil-2.8.2-py2.py3-none-any.whl (247 kB)
     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 247.7/247.7 KB 8.8 MB/s eta 0:00:00
Requirement already satisfied: urllib3<2.1,>=1.25.4 in /usr/lib/python3/dist-packages (from botocore<1.32.0,>=1.31.84->boto3) (1.26.5)
Requirement already satisfied: six>=1.5 in /usr/lib/python3/dist-packages (from python-dateutil<3.0.0,>=2.1->botocore<1.32.0,>=1.31.84->boto3) (1.16.0)
Installing collected packages: python-dateutil, botocore, s3transfer, boto3
Successfully installed boto3-1.28.84 botocore-1.31.84 python-dateutil-2.8.2 s3transfer-0.7.0
mahsan@vmmint:~/Ansible/playbooks$ 


mahsan@vmmint:~/Ansible/playbooks$ ansible-inventory --list
{
    "_meta": {
        "hostvars": {
            "ec2-18-118-138-204.us-east-2.compute.amazonaws.com": {
                "ami_launch_index": 0,
                "architecture": "x86_64",
                "block_device_mappings": [
                    {
                        "device_name": "/dev/xvda",
                        "ebs": {
                            "attach_time": "2023-11-12T22:27:49+00:00",
                            "delete_on_termination": true,
                            "status": "attached",
                            "volume_id": "vol-0152bf853516fe0a9"
                        }
                    }
                ],
                "boot_mode": "uefi-preferred",
                "capacity_reservation_specification": {
                    "capacity_reservation_preference": "open"
                },
                "client_token": "terraform-20231112222747788000000002",
                "cpu_options": {
                    "core_count": 1,
                    "threads_per_core": 1
                 

mahsan@vmmint:~/Ansible/playbooks$ ansible-inventory --graph
@all:
  |--@aws_ec2:
  |  |--ec2-18-118-138-204.us-east-2.compute.amazonaws.com
  |  |--ec2-3-135-203-134.us-east-2.compute.amazonaws.com
  |  |--ec2-3-145-180-177.us-east-2.compute.amazonaws.com
  |--@ungrouped:
mahsan@vmmint:~/Ansible/playbooks$ 


mahsan@vmmint:~/Ansible/playbooks$ ansible-inventory --graph
@all:
  |--@arch_x86_64:
  |  |--ec2-18-221-170-43.us-east-2.compute.amazonaws.com
  |  |--ec2-3-142-174-59.us-east-2.compute.amazonaws.com
  |  |--ec2-3-149-255-45.us-east-2.compute.amazonaws.com
  |--@aws_ec2:
  |  |--ec2-18-221-170-43.us-east-2.compute.amazonaws.com
  |  |--ec2-3-142-174-59.us-east-2.compute.amazonaws.com
  |  |--ec2-3-149-255-45.us-east-2.compute.amazonaws.com
  |--@ungrouped:
mahsan@vmmint:~/Ansible/playbooks$ cat 01_aws_ec2.yml 
plugin: aws_ec2
region:
  - us-east-2
keyed_groups:
  - prefix: arch
    key: 'architecture'
  - prefix: arch
    key: 'tags'

ahsan@vmmint:~/Ansible/playbooks$ ansible-inventory --graph
@all:
  |--@arch_Enviroment_dev:
  |  |--ec2-3-149-255-45.us-east-2.compute.amazonaws.com
  |--@arch_Environment__prod:
  |  |--ec2-3-142-174-59.us-east-2.compute.amazonaws.com
  |--@arch_Environment_qa:
  |  |--ec2-18-221-170-43.us-east-2.compute.amazonaws.com
  |--@arch_x86_64:
  |  |--ec2-18-221-170-43.us-east-2.compute.amazonaws.com
  |  |--ec2-3-142-174-59.us-east-2.compute.amazonaws.com
  |  |--ec2-3-149-255-45.us-east-2.compute.amazonaws.com
  |--@aws_ec2:
  |  |--ec2-18-221-170-43.us-east-2.compute.amazonaws.com
  |  |--ec2-3-142-174-59.us-east-2.compute.amazonaws.com
  |  |--ec2-3-149-255-45.us-east-2.compute.amazonaws.com
  |--@ungrouped:
mahsan@vmmint:~/Ansible/pl

ahsan@vmmint:~/Ansible/playbooks$ ansible-inventory --graph
@all:
  |--@arch_x86_64:
  |  |--ec2-18-221-170-43.us-east-2.compute.amazonaws.com
  |  |--ec2-3-142-174-59.us-east-2.compute.amazonaws.com
  |  |--ec2-3-149-255-45.us-east-2.compute.amazonaws.com
  |--@aws_ec2:
  |  |--ec2-18-221-170-43.us-east-2.compute.amazonaws.com
  |  |--ec2-3-142-174-59.us-east-2.compute.amazonaws.com
  |  |--ec2-3-149-255-45.us-east-2.compute.amazonaws.com
  |--@aws_region_us_east_2:
  |  |--ec2-18-221-170-43.us-east-2.compute.amazonaws.com
  |  |--ec2-3-142-174-59.us-east-2.compute.amazonaws.com
  |  |--ec2-3-149-255-45.us-east-2.compute.amazonaws.com
  |--@qa:
  |  |--ec2-18-221-170-43.us-east-2.compute.amazonaws.com
  |--@tag_Enviroment_dev:
  |  |--ec2-3-149-255-45.us-east-2.compute.amazonaws.com
  |--@tag_Environment__prod:
  |  |--ec2-3-142-174-59.us-east-2.compute.amazonaws.com
  |--@tag_Environment_qa:
  |  |--ec2-18-221-170-43.us-east-2.compute.amazonaws.com
  |--@ungrouped:
mahsan@vmmint:~/Ansible/playbooks$ cat 01
01_aws_ec2.yml  01-ping.yml     
mahsan@vmmint:~/Ansible/playbooks$ cat 01_aws_ec2.yml 
plugin: aws_ec2
region:
  - us-east-2
keyed_groups:
  - prefix: arch
    key: 'architecture'
  - prefix: tag
    key: 'tags'
  - prefix: tag
    key: 'tags'
  - prefix: aws_region
    key: placement.region
  - key: tags.Environment
    separator: ''

mahsan@vmmint:~/Ansible/playbooks$ 




</pre>


