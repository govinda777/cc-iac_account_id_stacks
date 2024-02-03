data "aws_ami" "latest_amazon_linux" {
  most_recent = true

  owners = ["amazon"]  # AWS account ID da Amazon

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


resource "aws_instance" "this" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  tags = {
    Name = var.resource_name
  }
}