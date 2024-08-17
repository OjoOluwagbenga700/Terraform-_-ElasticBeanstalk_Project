output "vpc_id" {
  value = module.vpc.vpc_id
}

output "tf_ebs_endpoint_url" {
  value = module.elasticbeanstalk.tf_ebs_endpoint_url
}
