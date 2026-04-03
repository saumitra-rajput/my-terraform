# Module outputs

output "instance_id" {
    description = "Output value EC2 instance ID"
    value       = aws_instance.myec2.id
}

output "instance_id" {
    description = "Output value EC2 publicIP"
    value       = aws_instance.myec2.publicIP
}

output "instance_id" {
    description = "Output value EC2 privateIP"
    value       = aws_instance.myec2.privateIP
}