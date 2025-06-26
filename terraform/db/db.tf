resource "aws_db_subnet_group" "lamp_db_subnet_group" {
  name       = "lamp-db-subnet-group"
  subnet_ids = [
    var.db_subnet_id_a,
    var.db_subnet_id_b
  ]

  tags = {
    Name = "LAMP DB Subnet Group"
  }
}

resource "aws_db_instance" "lamp_db" {
  identifier              = "lamp-db"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  db_name                 = var.db_name
  username                = var.db_user
  password                = var.db_password
  parameter_group_name    = "default.mysql8.0"
  skip_final_snapshot     = true
  publicly_accessible     = false
  vpc_security_group_ids  = [var.db_sg_id]
  db_subnet_group_name    = aws_db_subnet_group.lamp_db_subnet_group.name

  tags = {
    Name = "LAMP_DB_Instance"
  }
}
