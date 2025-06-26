# terraform/vpc/outputs.tf

output "vpc_id" {
  value = aws_vpc.main.id
}

output "web_subnet_id" {
  value = aws_subnet.web_subnet_a.id
}

output "app_subnet_id" {
  value = aws_subnet.app_subnet_a.id
}

output "db_subnet_id" {
  value = aws_subnet.db_subnet_a.id
}

output "db_subnet_id_a" {
  value = aws_subnet.db_subnet_a.id
}

output "db_subnet_id_b" {
  value = aws_subnet.db_subnet_b.id
}

output "test_db_a" {
  value = aws_subnet.db_subnet_a.id
}
