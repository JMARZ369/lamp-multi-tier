# terraform/web/outputs.tf 

output "web_public_ip" {
  value = aws_instance.web.public_ip
}
