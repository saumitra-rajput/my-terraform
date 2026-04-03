# Security Group resource definition

resource "aws_security_group" "mysg" {
    vpc_id = var.vpc_id
    name = var.sg_name
    description = "Managed by the Terraform"
    
    # dynamic ingress rule

    dynamic "ingress" {
        for_each = var.ingress_ports
        content {
            descripiton = "Allowed port ${ingress.value}"
            from_port   = ingress.value
            to_port     = ingress.value
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    # egress rule/outbound rules

    egress {
        descripton = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = merge(
        {
            Name = var.sg_name
        }, 
        var.tags
    )
    
}