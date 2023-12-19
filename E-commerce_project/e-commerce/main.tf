#Create vpc
module "vpc" {
  source                  = "../modules/vpc"
  project_name            = var.project_name
  region                  = var.region
  vpc_cidr                = var.vpc_cidr
  public_subnet_az1_cidr  = var.public_subnet_az1_cidr
  public_subnet_az2_cidr  = var.public_subnet_az2_cidr
  private_subnet-az1_cidr = var.private_subnet-az1_cidr
  private_subnet-az2_cidr = var.private_subnet-az2_cidr
}

#Create Natgateway and Private route table 

module "nat_gateway" {
  source                = "../modules/natgateway"
  vpc_id                = module.vpc.vpc_id
  public_subnet_az1_id  = module.vpc.public_subnet_az1_id
  public_subnet_az2_id  = module.vpc.public_subnet_az2_id
  igw                   = module.vpc.igw
  private_subnet-az1_id = module.vpc.private_subnet-az1_id
  private_subnet-az2_id = module.vpc.private_subnet-az2_id

}

#create security groups
module "security_group" {
  source       = "../modules/securitygroup"
  project_name = module.vpc.project_name
  vpc_id       = module.vpc.vpc_id
}


