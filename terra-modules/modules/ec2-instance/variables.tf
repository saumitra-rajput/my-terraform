# Module inputs

variable "ami_id" {
    description = "EC2 image ID"
    type        = string
}

variable "instance_type" {
    description = "EC2 image instance type ID"
    type        = string
    default     = "t3.micro"
}

variable "subnet_id" {
    description = "EC2 subnet ID"
    type        = string
}

variable "security_group_ids" {
    description = "EC2 security groups ID"
    type        = list(string)
}

variable "instance_name" {
    description = "EC2 instance name ID"
    type        = string
}

variable "tags" {
    description = "EC2 tags ID"
    type        = map(string)
    default     = {}
}