module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.0"

  name = "ec2-jupyter"

  instance_type          = "t2.micro"
  key_name               = "jupyter"
  monitoring             = true

  vpc_security_group_ids = [aws_security_group.ec2_instance_sg.id]
  subnet_id              = var.defaut-vpc-id

  tags = {
    Terraform   = "true"
  }
}

resource "aws_security_group" "ec2_instance_sg" {
  name        = "ec2-instance-sg"
  description = "Allow instances in the private subnets to access internet."
  vpc_id      = var.defaut-vpc-id

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