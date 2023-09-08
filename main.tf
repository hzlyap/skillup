terraform {
  backend "s3" {
    bucket = "skillup-s3-bucket-hazel.yap-001"
    key    = "terraform-hazel.yap.tfstate"
    region = "eu-west-1"
  }
}

provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
}

module "vpc" {
  source = "./modules/vpc"

  skillup_name        = var.skillup_name
  knox_id             = var.knox_id
  region              = var.region
  vpc_cidr_block      = var.vpc_cidr_block
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zones  = var.availability_zones
  global_tags         = var.global_tags
}

module "alb" {
  source = "./modules/alb"

  skillup_name   = var.skillup_name
  knox_id        = var.knox_id
  alb_knox_id    = var.alb_knox_id
  alb_cidr_block = var.alb_cidr_block
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.public_subnet_ids
  global_tags    = var.global_tags
}

module "asg" {
  source = "./modules/asg"

  skillup_name = var.skillup_name
  knox_id      = var.knox_id
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids
  alb_tg_arn   = module.alb.alb_tg_arn
  alb_sg_id    = module.alb.alb_sg_id
  
  image_id             = var.image_id
  instance_type        = var.instance_type
  iam_instance_profile = var.iam_instance_profile
  keypair              = var.keypair
  user_data            = file(var.user_data)

  asg_min_size         = var.asg_min_size
  asg_max_size         = var.asg_max_size
  asg_desired_capacity = var.asg_desired_capacity

  global_tags          = var.global_tags
}
