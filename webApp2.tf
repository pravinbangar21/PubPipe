terraform {
required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 3.0"
  }
}
}

// this section declares the query to get ami info out of AWS
data "aws_ami" "amazon_linux2_ami" {
most_recent = true
owners = ["amazon"]

filter {
name = "image-id"
values = ["ami-010aff33ed5991201"]
}
}

// this section declares that we need a security group resource with its rules
resource "aws_security_group" "allow_webapp_traffic" {
#name        = "allow_webapp_traffic"
description = "Allow inbound traffic"

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
protocol    = "-1"
cidr_blocks = ["0.0.0.0/0"]
}

tags = {
Name = "allow_my_laptop"
}
}

// this section declares that we need an aws instance along with its configuration
resource "aws_instance" "webapp" {
ami           = data.aws_ami.amazon_linux2_ami.id
instance_type = "t2.micro"
vpc_security_group_ids = [aws_security_group.allow_webapp_traffic.id]
key_name = "linux8p1"

user_data = <<-EOF
            #!/bin/bash
            sudo yum update -y
            sudo yum install httpd -y
            sudo service httpd start
            sudo chkconfig httpd on
            echo "<html><h1>Hello...Pravin...!!...Your terraform deployment worked !!!</h1></html>" | sudo tee /var/www/html/index.html
            hostname -f >> /var/www/html/index.html
            EOF

tags = {
Name = "myfirsttfinstance"
}
}

output "instance_ip" {
value = aws_instance.webapp.public_ip
}
