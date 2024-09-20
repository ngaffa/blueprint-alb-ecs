# Undefined Variables

variable "task_family_name" {
  description = "The family name for the ECS task definition."
}

variable "execution_role_arn" {
  description = "The ARN of the IAM role that grants the ECS task permissions."
}

variable "cpu" {
  description = "The number of CPU units for the ECS task."
}

variable "memory" {
  description = "The amount of memory (in MiB) for the ECS task."
}

variable "container_name" {
  description = "The name of the container in the ECS task definition."
}

variable "container_port" {
  description = "The port on which the container listens."
}

variable "host_port" {
  description = "The port on the host to which the container's port is mapped."
}

variable "private_sg_1_name" {
  description = "The name of the first private security group."
}

variable "private_sg_2_name" {
  description = "The name of the second private security group."
}
