# this file will holds our variables

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "vpc_cidr" {
  description = "vpc cider block range"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "cidr block for vpc subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "type of instance"
  type        = string
  default     = "t3.micro"
}


variable "project_name" {
  description = "Project name"
  type        = string
  # no default required from user
}

variable "environment" {
  description = "Type of environment"
  type        = string
  default     = "dev"
}

variable "allowed_ports" {
  description = "Allowed ports"
  type        = list(string)
  default     = [22, 80, 443]
}

variable "extra_tags" {
  description = "Extra tags"
  type        = map(string)
  default     = {}
}
