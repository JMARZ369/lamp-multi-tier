# terraform/web/ec2.tf

resource "aws_instance" "web" {
  ami                         = "ami-06971c49acd687c30"  # Amazon Linux 2023 us-east-2
  instance_type               = "t2.micro"
  subnet_id                   = var.web_subnet_id
  vpc_security_group_ids      = [var.web_sg_id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  # user_data = file("${path.module}/../../scripts/user_data_web.sh") If not using Ansible make your own script

  tags = {
    Name = "Web-Tier"
  }
}
