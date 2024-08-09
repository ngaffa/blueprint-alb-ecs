# default.tfvars

# AWS Provider settings
region  = "eu-west-1"
profile = "ym-dev-cli"

# Tagging
environment = "dev"
project     = "Blueprints"
developer   = "yiming"
architect   = "Naoufal"
company     = "GAFA CLOUD"

# VPC Creation
create_vpc      = true
existing_vpc_id = ""
vpc_cidr        = "<VPC_CIDR>"

# Subnet configuration
private_subnet_cidr_blocks = ["12.0.0.0/26", "12.0.0.64/26"]
private_subnet_azs         = ["eu-west-1a", "eu-west-1b"]
public_subnet_cidr_blocks  = ["12.0.0.128/27", "12.0.0.160/27"]
public_subnet_azs          = ["eu-west-1a", "eu-west-1b"]

# Existing subnet IDs (if `create_vpc` is false)
existing_private_subnet_ids = [] # IDs of existing private subnets to use if not creating new ones
existing_public_subnet_ids  = [] # IDs of existing public subnets to use if not creating new ones   

# Resource-specific settings
vpc_name                   = "vpc-ew1-blueprint-ecs"
private_subnet_name_format = "private_subnet_%d-ew1-blueprint-ecs-PrivateSubnet-%s"
public_subnet_name_format  = "public_subnet_%d-ew1-blueprint-ecs-PublicSubnet-%s"
igw_name                   = "igw-ew1-blueprint-ecs"
public_route_cidr_block    = "0.0.0.0/0"
public_route_table_name    = "public_rt-ew1-blueprint-ecs"
private_route_table_name   = "private_rt-ew1-blueprint-ecs"
ami_id                     = "ami-0bd0f7e25c32e69f6"
instance_type              = "t2.micro"
public_instance_name       = "EC2_1-ew1-blueprint-ecs-PublicSubnet-a"
private_instance_name      = "EC2_2-ew1-blueprint-ecs-PrivateSubnet-a"
s3_bucket_name             = "ym-s3-bucket-ew1-blueprint-ecs"
