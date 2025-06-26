# terraform/app/ec2.tf 

resource "aws_instance" "app" {
  ami                    = "ami-06971c49acd687c30"  # Amazon Linux 2023 in us-east-2
  instance_type          = "t2.micro"
  subnet_id              = var.app_subnet_id
  vpc_security_group_ids = [var.app_sg_id]
  key_name               = var.key_name

  # user_data = file("${path.module}/../../scripts/user_data_app.sh") If not using Ansible make your own script

  tags = {
    Name = "App-Tier"
  }
}
