
  resource "aws_elastic_beanstalk_application" "tf_ebs_app" {
    name        = var.application_name
  } 

# Create an Elastic Beanstalk Application Version
resource "aws_elastic_beanstalk_application_version" "my_app_version" {
  application = aws_elastic_beanstalk_application.tf_ebs_app.name
  name        = "my-app-version"
  bucket      = var.bucket_id
  key         = var.object_app_code_id

  depends_on = [
    aws_elastic_beanstalk_application.tf_ebs_app,
    
  ]
}

  resource "aws_elastic_beanstalk_environment" "tf_ebs_enviroment" {
    name                = var.enviroment_name
    application         = aws_elastic_beanstalk_application.tf_ebs_app.name
    solution_stack_name = var.solution_stack_name
    tier                = var.tier
    version_label       = aws_elastic_beanstalk_application_version.my_app_version.name
  

    setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }
setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = join(",", [var.public_subnet_az1_id, var.public_subnet_az2_id])
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value = join(",", [var.private_subnet_az1_id, var.private_subnet_az2_id])

  }
    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "InstanceType"
        value     = var.instance_type
    }

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "IamInstanceProfile"
        value     = "arn:aws:iam::969446871231:instance-profile/EC2instanceprofilerole"
    }
    
    setting {
        namespace = "aws:autoscaling:asg"
        name      = "MaxSize"
        value     = var.max_size
    }

    setting {
        namespace = "aws:autoscaling:asg"
        name      = "MinSize"
        value     = var.min_size
    }
    setting {
        namespace = "aws:elasticbeanstalk:environment"
        name      = "ServiceRole"
        value     = "arn:aws:iam::969446871231:role/service-role/aws-elasticbeanstalk-service-role"
}
      
    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "SecurityGroups"
        value     = var.ec2_security_group_id
    }
    setting {
   namespace = "aws:elasticbeanstalk:application:environment"
    name      = "var.bucket_name"
    value     = var.bucket_id
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "app_code/Dockerfile.zip"
    value     = var.object_app_code_id
  }

    depends_on = [
    aws_elastic_beanstalk_application_version.my_app_version
    
  ]
    
  }


  ## Create the Elastic Beanstalk service role
#resource "aws_iam_role" "elasticbeanstalk_service_role" {
  #name               = "tf-elasticbeanstalk-service-role"
  #assume_role_policy = data.aws_iam_policy_document.elasticbeanstalk_service_role_policy.json
#}

# Define the trust policy for the Elastic Beanstalk service role
#data "aws_iam_policy_document" "elasticbeanstalk_service_role_policy" {
 # statement {
   # actions = ["sts:AssumeRole"]
   # principals {
     # type        = "Service"
      #identifiers = ["elasticbeanstalk.amazonaws.com"]
    #}
  #}
#}

# Attach the AWSElasticBeanstalkRoleCore 
#resource "aws_iam_role_policy_attachment" "eb_Role_Core" {
  #role       = aws_iam_role.elasticbeanstalk_service_role.name
  #policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkRoleCore"
#}

# Attach the AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy managed policy
#resource "aws_iam_role_policy_attachment" "eb_role_policy_attachment" {
  #role       = aws_iam_role.elasticbeanstalk_service_role.name
  ##policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy"

#}
# Create the IAM role for the instance profile
#resource "aws_iam_role" "iam_instance_role" {
  #name               = "tf-iam-instance-role"
  #assume_role_policy = data.aws_iam_policy_document.iam_instance_role_policy.json
#}

# Define the trust policy for the IAM role
#data "aws_iam_policy_document" "iam_instance_role_policy" {
  #statement {
    #actions = ["sts:AssumeRole"]
    #principals {
     # type        = "Service"
      #identifiers = ["ec2.amazonaws.com"]
    #}
  #}
#}

# Attach the AWSElasticBeanstalkWebTier managed policy
#resource "aws_iam_role_policy_attachment" "web_tier" {
  ###}

# Create the instance profile and associate it with the IAM role
#resource "aws_iam_instance_profile" "iam_instance_profile" {
  #name = "iam-instance-profile"
  #role = aws_iam_role.iam_instance_role.name
#}
