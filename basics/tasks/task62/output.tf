# this file contain requested outputs


output "vpc_id" {
	description = "The id of the VPC"
	value 	    = aws_vpc.myvpc.id
}

output "subnet_id" {
        description = "The id of the public subnet"
        value       = aws_subnet.mysub.id
}

output "instance_id" {
        description = "The ID of the EC2 instance"
        value       = aws_instance.myec2.id
}


output "instance_public_ip" {
        description = "The public ip of the EC2 instance"
        value       = aws_instance.myec2.public_ip
}

output "instance_public_dns" {
        description = "The ID of the DNS name of ec2"
        value       = aws_instance.myec2.public_dns
}


output "security_group_id" {
        description = "The ID of the security group"
        value       = aws_security_group.mysg.id
}




