<pre>
<h2> Create EC2 via Terraform and install Ansible via pip </h2>


mahsan@vmmint:~/OldStuff-2023-11-11/terraform/terraform_Ansible_EC2$ cat main.tf 
provider "aws" {
  region = "us-east-2"
}

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "http_server_sg" {
  name = "http_server_sg"
  ##vpc_id = "vpc-0c867cff15e80e304"
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "http_server_sg"
  }
}

resource "aws_instance" "http_servers" {
  ami                    = "ami-01103fb68b3569475"
  count = 2
  key_name               = "terraform-key"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]
  subnet_id              = "subnet-0d807dc28683ac161"
  //  subnet_id = data.aws_subnets.default_subnets.ids[0]



  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("./terraform-key.pem")
  }

  provisioner "remote-exec" {
    inline = [
        "sudo yum install python -y",
        "sudo yum install python-pip -y",
        "sudo pip install ansible",
        "sudo useradd ansadmin",
        "sudo echo -e "##Redhat64##\n##Redhat64##" |passwd ansadmin"
        //"sudo echo "ansadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers"
      
    ]
  }

}


mahsan@vmmint:~/OldStuff-2023-11-11/terraform/terraform_Ansible_EC2$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_default_vpc.default will be created
  + resource "aws_default_vpc" "default" {
      + arn                                  = (known after apply)
      + cidr_block                           = (known after apply)
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + existing_default_vpc                 = (known after apply)
      + force_destroy                        = false
      + id                                   = (known after apply)
      + instance_tenancy                     = (known after apply)
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags_all                             = (known after apply)
    }

  # aws_instance.http_servers[0] will be created
  + resource "aws_instance" "http_servers" {
      + ami                                  = "ami-01103fb68b3569475"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "terraform-key"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = "subnet-0d807dc28683ac161"
      + tags_all                             = (known after apply)
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)
    }

  # aws_instance.http_servers[1] will be created
  + resource "aws_instance" "http_servers" {
      + ami                                  = "ami-01103fb68b3569475"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "terraform-key"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = "subnet-0d807dc28683ac161"
      + tags_all                             = (known after apply)
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)
    }

  # aws_security_group.http_server_sg will be created
  + resource "aws_security_group" "http_server_sg" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = "http_server_sg"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "name" = "http_server_sg"
        }
      + tags_all               = {
          + "name" = "http_server_sg"
        }
      + vpc_id                 = (known after apply)
    }

Plan: 4 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_default_vpc.default: Creating...
aws_default_vpc.default: Creation complete after 2s [id=vpc-0c867cff15e80e304]
aws_security_group.http_server_sg: Creating...
aws_security_group.http_server_sg: Creation complete after 2s [id=sg-00a347dc59ba5cc8d]
aws_instance.http_servers[1]: Creating...
aws_instance.http_servers[0]: Creating...
aws_instance.http_servers[1]: Still creating... [10s elapsed]
aws_instance.http_servers[0]: Still creating... [10s elapsed]
aws_instance.http_servers[1]: Still creating... [20s elapsed]
aws_instance.http_servers[0]: Still creating... [20s elapsed]
aws_instance.http_servers[0]: Provisioning with 'remote-exec'...
aws_instance.http_servers[0] (remote-exec): Connecting to remote host via SSH...
aws_instance.http_servers[0] (remote-exec):   Host: 18.119.140.188
aws_instance.http_servers[0] (remote-exec):   User: ec2-user
aws_instance.http_servers[0] (remote-exec):   Password: false
aws_instance.http_servers[0] (remote-exec):   Private key: true
aws_instance.http_servers[0] (remote-exec):   Certificate: false
aws_instance.http_servers[0] (remote-exec):   SSH Agent: true
aws_instance.http_servers[0] (remote-exec):   Checking Host Key: false
aws_instance.http_servers[0] (remote-exec):   Target Platform: unix
aws_instance.http_servers[0] (remote-exec): Connecting to remote host via SSH...
aws_instance.http_servers[0] (remote-exec):   Host: 18.119.140.188
aws_instance.http_servers[0] (remote-exec):   User: ec2-user
aws_instance.http_servers[0] (remote-exec):   Password: false
aws_instance.http_servers[0] (remote-exec):   Private key: true
aws_instance.http_servers[0] (remote-exec):   Certificate: false
aws_instance.http_servers[0] (remote-exec):   SSH Agent: true
aws_instance.http_servers[0] (remote-exec):   Checking Host Key: false
aws_instance.http_servers[0] (remote-exec):   Target Platform: unix
aws_instance.http_servers[0] (remote-exec): Connected!
aws_instance.http_servers[1]: Still creating... [30s elapsed]
aws_instance.http_servers[0]: Still creating... [30s elapsed]
aws_instance.http_servers[0] (remote-exec): Amazon  ---  B/s |   0  B     --:-- ETA
aws_instance.http_servers[0] (remote-exec): Amazon  ---  B/s |   0  B     --:-- ETA
aws_instance.http_servers[0] (remote-exec): Amazon   25 MB/s |  18 MB     00:00
aws_instance.http_servers[1]: Provisioning with 'remote-exec'...
aws_instance.http_servers[1] (remote-exec): Connecting to remote host via SSH...
aws_instance.http_servers[1] (remote-exec):   Host: 18.188.160.67
aws_instance.http_servers[1] (remote-exec):   User: ec2-user
aws_instance.http_servers[1] (remote-exec):   Password: false
aws_instance.http_servers[1] (remote-exec):   Private key: true
aws_instance.http_servers[1] (remote-exec):   Certificate: false
aws_instance.http_servers[1] (remote-exec):   SSH Agent: true
aws_instance.http_servers[1] (remote-exec):   Checking Host Key: false
aws_instance.http_servers[1] (remote-exec):   Target Platform: unix
aws_instance.http_servers[0] (remote-exec): Amazon  ---  B/s |   0  B     --:-- ETA
aws_instance.http_servers[1]: Still creating... [40s elapsed]
aws_instance.http_servers[0]: Still creating... [40s elapsed]
aws_instance.http_servers[0] (remote-exec): Amazon  ---  B/s |   0  B     --:-- ETA
aws_instance.http_servers[0] (remote-exec): Amazon  521 kB/s | 162 kB     00:00
aws_instance.http_servers[1] (remote-exec): Connecting to remote host via SSH...
aws_instance.http_servers[1] (remote-exec):   Host: 18.188.160.67
aws_instance.http_servers[1] (remote-exec):   User: ec2-user
aws_instance.http_servers[1] (remote-exec):   Password: false
aws_instance.http_servers[1] (remote-exec):   Private key: true
aws_instance.http_servers[1] (remote-exec):   Certificate: false
aws_instance.http_servers[1] (remote-exec):   SSH Agent: true
aws_instance.http_servers[1] (remote-exec):   Checking Host Key: false
aws_instance.http_servers[1] (remote-exec):   Target Platform: unix
aws_instance.http_servers[0] (remote-exec): Dependencies resolved.
aws_instance.http_servers[0] (remote-exec): ========================================
aws_instance.http_servers[0] (remote-exec):  Package
aws_instance.http_servers[0] (remote-exec):         Arch   Version
aws_instance.http_servers[0] (remote-exec):                       Repository   Size
aws_instance.http_servers[0] (remote-exec): ========================================
aws_instance.http_servers[0] (remote-exec): Installing:
aws_instance.http_servers[0] (remote-exec):  python-unversioned-command
aws_instance.http_servers[0] (remote-exec):         noarch 3.9.16-1.amzn2023.0.5
aws_instance.http_servers[0] (remote-exec):                       amazonlinux  11 k

aws_instance.http_servers[0] (remote-exec): Transaction Summary
aws_instance.http_servers[0] (remote-exec): ========================================
aws_instance.http_servers[0] (remote-exec): Install  1 Package

aws_instance.http_servers[0] (remote-exec): Total download size: 11 k
aws_instance.http_servers[0] (remote-exec): Installed size: 23
aws_instance.http_servers[0] (remote-exec): Downloading Packages:
aws_instance.http_servers[0] (remote-exec): Amazon  ---  B/s |   0  B     --:-- ETA
aws_instance.http_servers[0] (remote-exec): python- ---  B/s |   0  B     --:-- ETA
aws_instance.http_servers[0] (remote-exec): python-  77 kB/s |  11 kB     00:00
aws_instance.http_servers[0] (remote-exec): ----------------------------------------
aws_instance.http_servers[0] (remote-exec): Total    48 kB/s |  11 kB     00:00
aws_instance.http_servers[0] (remote-exec): Running transaction check
aws_instance.http_servers[0] (remote-exec): Transaction check succeeded.
aws_instance.http_servers[0] (remote-exec): Running transaction test
aws_instance.http_servers[0] (remote-exec): Transaction test succeeded.
aws_instance.http_servers[0] (remote-exec): Running transaction
aws_instance.http_servers[0] (remote-exec):   Preparing        :                1/1
aws_instance.http_servers[0] (remote-exec):   Installing       : pytho [      ] 1/1
aws_instance.http_servers[0] (remote-exec):   Installing       : pytho [=     ] 1/1
aws_instance.http_servers[0] (remote-exec):   Installing       : pytho [====  ] 1/1
aws_instance.http_servers[0] (remote-exec):   Installing       : python-unver   1/1
aws_instance.http_servers[0] (remote-exec):   Running scriptlet: python-unver   1/1
aws_instance.http_servers[0] (remote-exec):   Verifying        : python-unver   1/1
aws_instance.http_servers[0] (remote-exec): ========================================
aws_instance.http_servers[0] (remote-exec): WARNING:
aws_instance.http_servers[0] (remote-exec):   A newer release of "Amazon Linux" is available.

aws_instance.http_servers[0] (remote-exec):   Available Versions:

aws_instance.http_servers[0] (remote-exec):   Version 2023.2.20230920:
aws_instance.http_servers[0] (remote-exec):     Run the following command to upgrade to 2023.2.20230920:

aws_instance.http_servers[0] (remote-exec):       dnf upgrade --releasever=2023.2.20230920

aws_instance.http_servers[0] (remote-exec):     Release notes:
aws_instance.http_servers[0] (remote-exec):      https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.2.20230920.html

aws_instance.http_servers[0] (remote-exec):   Version 2023.2.20231002:
aws_instance.http_servers[0] (remote-exec):     Run the following command to upgrade to 2023.2.20231002:

aws_instance.http_servers[0] (remote-exec):       dnf upgrade --releasever=2023.2.20231002

aws_instance.http_servers[0] (remote-exec):     Release notes:
aws_instance.http_servers[0] (remote-exec):      https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.2.20231002.html

aws_instance.http_servers[0] (remote-exec):   Version 2023.2.20231011:
aws_instance.http_servers[0] (remote-exec):     Run the following command to upgrade to 2023.2.20231011:

aws_instance.http_servers[0] (remote-exec):       dnf upgrade --releasever=2023.2.20231011

aws_instance.http_servers[0] (remote-exec):     Release notes:
aws_instance.http_servers[0] (remote-exec):      https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.2.20231011.html

aws_instance.http_servers[0] (remote-exec):   Version 2023.2.20231016:
aws_instance.http_servers[0] (remote-exec):     Run the following command to upgrade to 2023.2.20231016:

aws_instance.http_servers[0] (remote-exec):       dnf upgrade --releasever=2023.2.20231016

aws_instance.http_servers[0] (remote-exec):     Release notes:
aws_instance.http_servers[0] (remote-exec):      https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.2.20231016.html

aws_instance.http_servers[0] (remote-exec):   Version 2023.2.20231018:
aws_instance.http_servers[0] (remote-exec):     Run the following command to upgrade to 2023.2.20231018:

aws_instance.http_servers[0] (remote-exec):       dnf upgrade --releasever=2023.2.20231018

aws_instance.http_servers[0] (remote-exec):     Release notes:
aws_instance.http_servers[0] (remote-exec):      https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.2.20231018.html

aws_instance.http_servers[0] (remote-exec):   Version 2023.2.20231026:
aws_instance.http_servers[0] (remote-exec):     Run the following command to upgrade to 2023.2.20231026:

aws_instance.http_servers[0] (remote-exec):       dnf upgrade --releasever=2023.2.20231026

aws_instance.http_servers[0] (remote-exec):     Release notes:
aws_instance.http_servers[0] (remote-exec):      https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.2.20231026.html

aws_instance.http_servers[0] (remote-exec):   Version 2023.2.20231030:
aws_instance.http_servers[0] (remote-exec):     Run the following command to upgrade to 2023.2.20231030:

aws_instance.http_servers[0] (remote-exec):       dnf upgrade --releasever=2023.2.20231030

aws_instance.http_servers[0] (remote-exec):     Release notes:
aws_instance.http_servers[0] (remote-exec):      https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.2.20231030.html

aws_instance.http_servers[0] (remote-exec): ========================================

aws_instance.http_servers[0] (remote-exec): Installed:
aws_instance.http_servers[0] (remote-exec):   python-unversioned-command-3.9.16-1.amzn2023.0.5.noarch

aws_instance.http_servers[0] (remote-exec): Complete!
aws_instance.http_servers[1] (remote-exec): Connected!
aws_instance.http_servers[0] (remote-exec): Last metadata expiration check: 0:00:03 ago on Sat Nov 11 19:10:00 2023.
aws_instance.http_servers[0] (remote-exec): Dependencies resolved.
aws_instance.http_servers[0] (remote-exec): ========================================
aws_instance.http_servers[0] (remote-exec):  Package     Arch   Version
aws_instance.http_servers[0] (remote-exec):                       Repository   Size
aws_instance.http_servers[0] (remote-exec): ========================================
aws_instance.http_servers[0] (remote-exec): Installing:
aws_instance.http_servers[0] (remote-exec):  python3-pip noarch 21.3.1-2.amzn2023.0.5
aws_instance.http_servers[0] (remote-exec):                       amazonlinux 1.8 M
aws_instance.http_servers[0] (remote-exec): Installing weak dependencies:
aws_instance.http_servers[0] (remote-exec):  libxcrypt-compat
aws_instance.http_servers[0] (remote-exec):              x86_64 4.4.33-7.amzn2023
aws_instance.http_servers[0] (remote-exec):                       amazonlinux  92 k

aws_instance.http_servers[0] (remote-exec): Transaction Summary
aws_instance.http_servers[0] (remote-exec): ========================================
aws_instance.http_servers[0] (remote-exec): Install  2 Packages

aws_instance.http_servers[0] (remote-exec): Total download size: 1.9 M
aws_instance.http_servers[0] (remote-exec): Installed size: 11 M
aws_instance.http_servers[0] (remote-exec): Downloading Packages:
aws_instance.http_servers[0] (remote-exec):         ---  B/s |   0  B     --:-- ETA
aws_instance.http_servers[0] (remote-exec): (1/2):  ---  B/s |   0  B     --:-- ETA
aws_instance.http_servers[0] (remote-exec): (1/2):  656 kB/s |  92 kB     00:00
aws_instance.http_servers[0] (remote-exec): (2/2):  666 kB/s |  94 kB     00:02 ETA
aws_instance.http_servers[0] (remote-exec): (2/2):  9.6 MB/s | 1.8 MB     00:00
aws_instance.http_servers[0] (remote-exec): ----------------------------------------
aws_instance.http_servers[0] (remote-exec): Total   6.7 MB/s | 1.9 MB     00:00
aws_instance.http_servers[0] (remote-exec): Running transaction check
aws_instance.http_servers[0] (remote-exec): Transaction check succeeded.
aws_instance.http_servers[0] (remote-exec): Running transaction test
aws_instance.http_servers[0] (remote-exec): Transaction test succeeded.
aws_instance.http_servers[0] (remote-exec): Running transaction
aws_instance.http_servers[0] (remote-exec):   Preparing        :  [=====      ] 1/1
aws_instance.http_servers[0] (remote-exec):   Preparing        :                1/1
aws_instance.http_servers[0] (remote-exec):   Installing       : libxc [      ] 1/2
aws_instance.http_servers[0] (remote-exec):   Installing       : libxc [=     ] 1/2
aws_instance.http_servers[0] (remote-exec):   Installing       : libxc [==    ] 1/2
aws_instance.http_servers[0] (remote-exec):   Installing       : libxc [===   ] 1/2
aws_instance.http_servers[0] (remote-exec):   Installing       : libxc [====  ] 1/2
aws_instance.http_servers[0] (remote-exec):   Installing       : libxc [===== ] 1/2
aws_instance.http_servers[0] (remote-exec):   Installing       : libxcrypt-co   1/2
aws_instance.http_servers[0] (remote-exec):   Installing       : pytho [      ] 2/2
aws_instance.http_servers[1] (remote-exec): Amazon  ---  B/s |   0  B     --:-- ETA
aws_instance.http_servers[0] (remote-exec):   Installing       : pytho [=     ] 2/2
aws_instance.http_servers[1] (remote-exec): Amazon  8.9 MB/s | 2.8 MB     00:01 ETA
aws_instance.http_servers[0] (remote-exec):   Installing       : pytho [==    ] 2/2
aws_instance.http_servers[1] (remote-exec): Amazon   26 MB/s |  18 MB     00:00
aws_instance.http_servers[0] (remote-exec):   Installing       : pytho [===   ] 2/2
aws_instance.http_servers[0] (remote-exec):   Installing       : pytho [====  ] 2/2
aws_instance.http_servers[0] (remote-exec):   Installing       : pytho [===== ] 2/2
aws_instance.http_servers[0] (remote-exec):   Installing       : python3-pip-   2/2
aws_instance.http_servers[0] (remote-exec):   Running scriptlet: python3-pip-   2/2
aws_instance.http_servers[0] (remote-exec):   Verifying        : libxcrypt-co   1/2
aws_instance.http_servers[0] (remote-exec):   Verifying        : python3-pip-   2/2
aws_instance.http_servers[0] (remote-exec): ========================================
aws_instance.http_servers[0] (remote-exec): WARNING:
aws_instance.http_servers[0] (remote-exec):   A newer release of "Amazon Linux" is available.

aws_instance.http_servers[0] (remote-exec):   Available Versions:

aws_instance.http_servers[0] (remote-exec):   Version 2023.2.20230920:
aws_instance.http_servers[0] (remote-exec):     Run the following command to upgrade to 2023.2.20230920:

aws_instance.http_servers[0] (remote-exec):       dnf upgrade --releasever=2023.2.20230920

aws_instance.http_servers[0] (remote-exec):     Release notes:
aws_instance.http_servers[0] (remote-exec):      https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.2.20230920.html

aws_instance.http_servers[0] (remote-exec):   Version 2023.2.20231002:
aws_instance.http_servers[0] (remote-exec):     Run the following command to upgrade to 2023.2.20231002:

aws_instance.http_servers[0] (remote-exec):       dnf upgrade --releasever=2023.2.20231002

aws_instance.http_servers[0] (remote-exec):     Release notes:
aws_instance.http_servers[0] (remote-exec):      https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.2.20231002.html

aws_instance.http_servers[0] (remote-exec):   Version 2023.2.20231011:
aws_instance.http_servers[0] (remote-exec):     Run the following command to upgrade to 2023.2.20231011:

aws_instance.http_servers[0] (remote-exec):       dnf upgrade --releasever=2023.2.20231011

aws_instance.http_servers[0] (remote-exec):     Release notes:
aws_instance.http_servers[0] (remote-exec):      https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.2.20231011.html

aws_instance.http_servers[0] (remote-exec):   Version 2023.2.20231016:
aws_instance.http_servers[0] (remote-exec):     Run the following command to upgrade to 2023.2.20231016:

aws_instance.http_servers[0] (remote-exec):       dnf upgrade --releasever=2023.2.20231016

aws_instance.http_servers[0] (remote-exec):     Release notes:
aws_instance.http_servers[0] (remote-exec):      https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.2.20231016.html

aws_instance.http_servers[0] (remote-exec):   Version 2023.2.20231018:
aws_instance.http_servers[0] (remote-exec):     Run the following command to upgrade to 2023.2.20231018:

aws_instance.http_servers[0] (remote-exec):       dnf upgrade --releasever=2023.2.20231018

aws_instance.http_servers[0] (remote-exec):     Release notes:
aws_instance.http_servers[0] (remote-exec):      https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.2.20231018.html

aws_instance.http_servers[0] (remote-exec):   Version 2023.2.20231026:
aws_instance.http_servers[0] (remote-exec):     Run the following command to upgrade to 2023.2.20231026:

aws_instance.http_servers[0] (remote-exec):       dnf upgrade --releasever=2023.2.20231026

aws_instance.http_servers[0] (remote-exec):     Release notes:
aws_instance.http_servers[0] (remote-exec):      https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.2.20231026.html

aws_instance.http_servers[0] (remote-exec):   Version 2023.2.20231030:
aws_instance.http_servers[0] (remote-exec):     Run the following command to upgrade to 2023.2.20231030:

aws_instance.http_servers[0] (remote-exec):       dnf upgrade --releasever=2023.2.20231030

aws_instance.http_servers[0] (remote-exec):     Release notes:
aws_instance.http_servers[0] (remote-exec):      https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.2.20231030.html

aws_instance.http_servers[0] (remote-exec): ========================================

aws_instance.http_servers[0] (remote-exec): Installed:
aws_instance.http_servers[0] (remote-exec):   libxcrypt-compat-4.4.33-7.amzn2023.x86_64
aws_instance.http_servers[0] (remote-exec):   python3-pip-21.3.1-2.amzn2023.0.5.noarch

aws_instance.http_servers[0] (remote-exec): Complete!
aws_instance.http_servers[0] (remote-exec): Collecting ansible
aws_instance.http_servers[0] (remote-exec):   Downloading ansible-8.6.1-py3-none-any.whl (48.3 MB)
aws_instance.http_servers[1]: Still creating... [50s elapsed]
aws_instance.http_servers[0]: Still creating... [50s elapsed]
aws_instance.http_servers[0] (remote-exec): 

aws_instance.http_servers[1]: Still creating... [1m10s elapsed]
aws_instance.http_servers[0]: Still creating... [1m10s elapsed]
aws_instance.http_servers[1]: Still creating... [1m20s elapsed]
aws_instance.http_servers[0]: Still creating... [1m20s elapsed]
aws_instance.http_servers[1]: Still creating... [1m30s elapsed]
aws_instance.http_servers[0]: Still creating... [1m30s elapsed]
aws_instance.http_servers[0]: Still creating... [1m40s elapsed]
aws_instance.http_servers[1]: Still creating... [1m40s elapsed]
aws_instance.http_servers[0] (remote-exec): Successfully installed MarkupSafe-2.1.3 ansible-8.6.1 ansible-core-2.15.6 importlib-resources-5.0.7 jinja2-3.1.2 packaging-23.2 resolvelib-1.0.1
aws_instance.http_servers[0] (remote-exec): WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv

aws_instance.http_servers[0]: Creation complete after 1m45s [id=i-042737ca5723cbea5]
aws_instance.http_servers[1]: Still creating... [1m50s elapsed]
aws_instance.http_servers[1] (remote-exec): Successfully installed MarkupSafe-2.1.3 ansible-8.6.1 ansible-core-2.15.6 importlib-resources-5.0.7 jinja2-3.1.2 packaging-23.2 resolvelib-1.0.1
aws_instance.http_servers[1] (remote-exec): WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv

aws_instance.http_servers[1]: Creation complete after 1m56s [id=i-007ab3e09f9835e16]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
mahsan@vmmint:~/OldStuff-2023-11-11/terraform/terraform_Ansible_EC2$ 



</pre>






