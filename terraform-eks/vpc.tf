# VPC module call

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  
  name = "${var.cluster_name}-vpc"	
  cidr = var.vpc_cidr

  azs             = ["${var.region}a", "${var.region}b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true # save costs
  enable_dns_hostnames = true

  # Required tags for Kubernetes load balancers
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = {
    Project = var.cluster_name
  }
}