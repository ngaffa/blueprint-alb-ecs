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
