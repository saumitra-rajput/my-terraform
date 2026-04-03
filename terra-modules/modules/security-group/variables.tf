# Module inputs

variable "vpc_id" {
    description = "VPC value"
    type        = string
}

variable "sg_name" {
    description = "Security group name"
    type        = string
}

variable "ingress_ports" {
    description = "Port rules of the Security Group"
    type        = list(number)
    default     = [22, 80]
}

variable "tags" {
    description = "Tag Names"
    type        = map(string)
    default     = {}
}
