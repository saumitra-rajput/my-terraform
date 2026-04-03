# All input variables

variable "region" {
    description = "Value of the AWS region"
    type        = string
    value       = "us-west-2"
}

variable "cluster_name" {
    description = "AWS Cluster Name"
    type        = string
    default     = "terraweek-eks"
}

variable "cluster_version" {
    description = "AWS Cluster version"
    type        = string
    default     = "1.31"
}

variable "node_instance_type" {
    description = "AWS node instance type"
    type        = string
    default     = "t3.medium"
}

variable "node_desired_count" {
    description = "AWS node desired count"
    type        = number
    default     = 2
}

variable "vpc_cidr" {
    description = "AWS vpc cidr"
    type        = string
    default     = "10.0.0.0/16"
}