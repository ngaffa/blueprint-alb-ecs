# terraform.tfvars
region  = "eu-west-1"
profile = "ym-dev-cli"

# for vpc optional creation

create_vpc = true

# Only required if create_vpc is true
vpc_cidr                   = "12.0.0.0/24"
private_subnet_cidr_blocks = ["12.0.0.0/26", "12.0.0.64/26"]
private_subnet_azs         = ["eu-west-1a", "eu-west-1b"]
public_subnet_cidr_blocks  = ["12.0.0.128/27", "12.0.0.160/27"]
public_subnet_azs          = ["eu-west-1a", "eu-west-1b"]

# Uncomment and provide values if create_vpc is false
# create_vpc = false
# existing_vpc_id = "vpc-12345678"
# existing_private_subnet_ids = ["subnet-12345678", "subnet-87654321"]
# existing_public_subnet_ids = ["subnet-23456789", "subnet-98765432"]
