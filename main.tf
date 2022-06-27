module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.0"

  name = "ec2-jupyter"

  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t2.micro"
  key_name               = "jupyter"
  monitoring             = true

  vpc_security_group_ids = [aws_security_group.ec2_instance_sg.id]
  subnet_id              = aws_subnet.my_subnet.id

  tags = {
    Terraform   = "true"
  }
}

resource "aws_security_group" "ec2_instance_sg" {
  name        = "ec2-instance-sg"
  description = "Allow instances in the private subnets to access internet."
  vpc_id      = aws_vpc.my_vpc.id
  ingress {
    description      = "Allow internet access from ec2"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  instance_tenancy = "default"    
}

resource "aws_subnet" "my_subnet" {
    vpc_id = "${aws_vpc.my_vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1"
}
