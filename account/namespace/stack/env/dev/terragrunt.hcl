inputs = {
  account       = "843210383"
  namespace     = "core"
  stack         = "tool_abc"
  env           = "dev"
  vpc           = "vpc-13cdea6b"
  subnet        = "subnet-a48fb48f"

  # ec2
  resource_name = "my_ec2_instance"
  resource_type = "aws_instance"
}

terraform {
  source = "../../../modules/ec2"
}

inputs = {
  resource_name = format("%s__%s__%s__%s__%s__%s", 
    inputs.account, 
    inputs.namespace, 
    inputs.stack, 
    inputs.env, 
    inputs.resource_name, 
    inputs.resource_type
  )
}