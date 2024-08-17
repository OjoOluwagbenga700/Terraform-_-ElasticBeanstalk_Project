project_name            = "tf-dev_app"
region                  = "us-east-2"
vpc_cidr                = "10.0.0.0/16"
public_subnet_az1_cidr  = "10.0.1.0/24"
public_subnet_az2_cidr  = "10.0.2.0/24"
private_subnet_az1_cidr = "10.0.3.0/24"
private_subnet_az2_cidr = "10.0.4.0/24"
application_name        = "tf-eb-app"
enviroment_name         = "tf-dev"
solution_stack_name     = "64bit Amazon Linux 2 v4.0.1 running Docker"
tier                    = "WebServer"
instance_type           = "t2.micro"
max_size                = 3
min_size                = 2
bucket_name             = "app700-bucket-198086"

