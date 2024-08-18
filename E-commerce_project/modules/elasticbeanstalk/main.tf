
  data "aws_caller_identity" "current" {}
  
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
        value     = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:instance-profile/EC2instanceprofilerole"
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
        value     = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/service-role/aws-elasticbeanstalk-service-role"
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

