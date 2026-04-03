# Module outputs

output "instance_id" {
    description = "Output value EC2 instance ID"
    value       = aws_instance.myec2.id
}

output "public_ip" {
    description = "Output value EC2 publicIP"
    value       = aws_instance.myec2.public_ip
}

output "private_ip" {
    description = "Output value EC2 privateIP"
    value       = aws_instance.myec2.private_ip
}
