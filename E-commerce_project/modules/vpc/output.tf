output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "region" {
  value = var.region
}

output "project_name" {
  value = var.project_name
}

output "igw" {
  value = aws_internet_gateway.igw.id
}

output "public_subnet_az1_id" {
  value = aws_subnet.public_subnet_az1.id
}

output "public_subnet_az2_id" {
  value = aws_subnet.public_subnet_az2.id
}
output "private_subnet_az1_id" {
  value = aws_subnet.private_subnet_az1.id
}

output "private_subnet_az2_id" {
  value = aws_subnet.private_subnet_az2.id
}
