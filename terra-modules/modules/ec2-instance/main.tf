# EC2 resource definition

resource "aws_instance" "myec2" {
    ami                    = var.ami_id
    instance_type          = var.instance_type
    subnet_id              = var.subnet_id
    vpc_security_group_ids = var.security_group_ids
    associate_public_ip_address = true  # for enable public IP

    tags = merge (
        {
            Name = var.instance_name
        }, 
        var.tags
    )
}