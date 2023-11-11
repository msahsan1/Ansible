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
  count = 3
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

