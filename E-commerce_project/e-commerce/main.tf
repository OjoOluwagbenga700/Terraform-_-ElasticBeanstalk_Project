#Create vpc
module "vpc" {
  source                  = "../modules/vpc"
  project_name            = var.project_name
  region                  = var.region
  vpc_cidr                = var.vpc_cidr
  public_subnet_az1_cidr  = var.public_subnet_az1_cidr
  public_subnet_az2_cidr  = var.public_subnet_az2_cidr
  private_subnet_az1_cidr = var.private_subnet_az1_cidr
  private_subnet_az2_cidr = var.private_subnet_az2_cidr
}

#Create Natgateway and Private route table 

module "nat_gateway" {
  source                = "../modules/natgateway"
  vpc_id                = module.vpc.vpc_id
  public_subnet_az1_id  = module.vpc.public_subnet_az1_id
  public_subnet_az2_id  = module.vpc.public_subnet_az2_id
  igw                   = module.vpc.igw
  private_subnet_az1_id = module.vpc.private_subnet_az1_id
  private_subnet_az2_id = module.vpc.private_subnet_az2_id

}

#create security groups
module "security_group" {
  source       = "../modules/securitygroup"
  project_name = module.vpc.project_name
  vpc_id       = module.vpc.vpc_id
}


module "s3" {
  source      = "../modules/s3"
  bucket_name = var.bucket_name
}

module "elasticbeanstalk" {
  source                    = "../modules/elasticbeanstalk"
  application_name          = var.application_name
  enviroment_name           = var.enviroment_name
  solution_stack_name       = var.solution_stack_name
  tier                      = var.tier
  bucket_id                 = module.s3.bucket_id
  object_app_code_id        = module.s3.object_app_code_id
  object_app_source_content = module.s3.object_app_code_content
  instance_type             = var.instance_type
  ec2_security_group_id     = module.security_group.ec2_security_group_id
  vpc_id                    = module.vpc.vpc_id
  max_size                  = var.max_size
  min_size                  = var.min_size
  private_subnet_az1_id     = module.vpc.private_subnet_az1_id
  private_subnet_az2_id     = module.vpc.private_subnet_az2_id
  public_subnet_az1_id      = module.vpc.public_subnet_az1_id
  public_subnet_az2_id      = module.vpc.public_subnet_az2_id
  bucket_name               = var.bucket_name
  

}