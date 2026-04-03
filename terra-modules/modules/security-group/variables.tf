# Module inputs

variable "vpc_id" {
    descripiton = "VPC value"
    type        = string
}

variable "sg_name" {
    descripiton = "Security group name"
    type        = string
}

variable "ingress_ports" {
    descripiton = "Port rules of the Security Group"
    type        = list(number)
    default     = [22, 80]
}

variable "tags" {
    descripiton = "Tag Names"
    type        = map(string)
    default     = {}
}
