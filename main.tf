provider "aws" {
  region = var.region
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  environment         = var.environment
}

module "security_group" {
  source      = "./modules/sg"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
}

module "ec2" {
  source          = "./modules/ec2"
  ami_id          = var.ami_id
  subnet_id       = module.vpc.subnet_id
  sg_id           = module.security_group.sg_id
  instance_type   = var.instance_type
  instance_count  = var.instance_count
  environment     = var.environment
}

module "s3" {
  source       = "./modules/s3"
  bucket_name  = var.bucket_name
  environment  = var.environment
}