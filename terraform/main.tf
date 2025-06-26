# terraform/main.tf

module "vpc" {
  source = "./vpc"
}

module "security" {
  source = "./security"
  vpc_id = module.vpc.vpc_id
}

module "web" {
  source        = "./web"
  web_subnet_id = module.vpc.web_subnet_id
  web_sg_id     = module.security.web_sg_id
  key_name      = var.key_name
}

module "app" {
  source         = "./app"
  app_subnet_id  = module.vpc.app_subnet_id
  app_sg_id      = module.security.app_sg_id
  key_name       = var.key_name
}

module "db" {
  source         = "./db"
  db_subnet_id_a = module.vpc.db_subnet_id_a
  db_subnet_id_b = module.vpc.db_subnet_id_b
  db_sg_id       = module.security.db_sg_id
  db_name        = "lampdb"
  db_user        = "lampuser"
  db_password    = "MySecurePass123!" # (use secrets manager for production)
}

