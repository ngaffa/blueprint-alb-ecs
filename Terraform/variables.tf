# variables.tf
variable "region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "eu-west-1"
}

variable "profile" {
  description = "The AWS profile to use"
  type        = string
  default     = "ym-dev-cli"
}

# variables for vpc optional creation

variable "create_vpc" {
  description = "Flag to determine whether to create a new VPC"
  type        = bool
  default     = true
}

variable "existing_vpc_id" {
  description = "ID of an existing VPC to use if not creating a new one"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "CIDR block for the new VPC"
  type        = string
  default     = "12.0.0.0/24"
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for private subnets if creating new VPC"
  type        = list(string)
  default     = ["12.0.0.0/26", "12.0.0.64/26"]
}

variable "private_subnet_azs" {
  description = "Availability zones for private subnets"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets if creating new VPC"
  type        = list(string)
  default     = ["12.0.0.128/27", "12.0.0.160/27"]
}

variable "public_subnet_azs" {
  description = "Availability zones for public subnets"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

# Default empty list indicating these are optional and will only be used if `create_vpc` is false
variable "existing_private_subnet_ids" {
  description = "IDs of existing private subnets to use if not creating new ones"
  type        = list(string)
  default     = []
}

# Default empty list indicating these are optional and will only be used if `create_vpc` is false
variable "existing_public_subnet_ids" {
  description = "IDs of existing public subnets to use if not creating new ones"
  type        = list(string)
  default     = []
}
