# default.tfvars

# AWS Provider settings
region  = "sfd"
profile = "sgfsd"

# Tagging
environment = "gsdf"
project     = "gsdfg"
developer   = "fsadf"
architect   = "asdf"
company     = "asdf"

# VPC Creation
create_vpc      = true
existing_vpc_id = "<EXISTING_VPC_ID>"
vpc_cidr        = "12.0.0.0/24"

# Subnet configuration
private_subnet_cidr_blocks = ["12.0.0.0/26", "12.0.0.64/26"]
private_subnet_azs         = ["eu-west-1a", "eu-west-1b"]
public_subnet_cidr_blocks  = ["12.0.0.128/27", "12.0.0.160/27"]
public_subnet_azs          = ["eu-west-1a", "eu-west-1b"]

# Existing subnet IDs (if `create_vpc` is false)
existing_private_subnet_ids = <EXISTING_PRIVATE_SUBNET_IDS>
existing_public_subnet_ids  = <EXISTING_PUBLIC_SUBNET_IDS>

# Resource-specific settings
vpc_name                   = "vpc"
private_subnet_name_format = "private_subnet_%d-ew1-blueprint-ecs-PrivateSubnet-%s"
public_subnet_name_format  = "public_subnet_%d-ew1-blueprint-ecs-PublicSubnet-%s"
igw_name                   = "igw"
public_route_cidr_block    = "0.0.0.0/0"
public_route_table_name    = "purt"
private_route_table_name   = "prrt"
ami_id                     = "ami-0bd0f7e25c32e69f6"
instance_type              = "t2.micro"
public_instance_name       = "EC2_1-ew1-blueprint-ecs-PublicSubnet-a"
private_instance_name      = "EC2_2-ew1-blueprint-ecs-PrivateSubnet-a"
s3_bucket_name             = "ym-s3-bucket-ew1-blueprint-ecs"