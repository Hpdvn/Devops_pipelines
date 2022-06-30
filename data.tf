data "aws_ami" "example" {
  most_recent = true

  owners = ["self"]
  tags = {
    produced-by = "packer"
  }
}