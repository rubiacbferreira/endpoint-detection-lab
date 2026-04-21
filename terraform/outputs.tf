output "linux_public_ip" {
  value = aws_instance.linux.public_ip
}

output "windows_public_ip" {
  value = aws_instance.windows.public_ip
}

output "linux_instance_id" {
  value = aws_instance.linux.id
}

output "windows_instance_id" {
  value = aws_instance.windows.id
}