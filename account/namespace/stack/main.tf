
variable "" {
  
}

module "my_ec2_instance" {
    source        = "../../../modules/ec2"
    instance_type = "t3.small"
    subnet_id = "subnet-a48fb48f"
    resource_name = "my_ec2_instance"
}

resource "aws_security_group" "example_sg" {
    name = "example_security_group"

    ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
    InstanceID = module.my_ec2_instance.instance_id
    }
}