# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet az1 
# terraform aws allocate elastic ip
resource "aws_eip" "eip_for_nat_gateway_az1" {
  domain        = "vpc"
  tags   = {
    Name = "eip_nat_gateway_az1"
  }
}

# create nat gateway in public subnet az1
# terraform create aws nat gateway
resource "aws_nat_gateway" "nat_gateway_az1" {
  allocation_id = aws_eip.eip_for_nat_gateway_az1.id
  subnet_id     = var.public_subnet_az1_id

  tags   = {
    Name = "nat_gateway_az1"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  # on the internet gateway for the vpc.
  depends_on = [var.igw]
}



# create private route table az1 and add route through nat gateway az1
# terraform aws create route table
resource "aws_route_table" "private_route_table_az1" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_gateway_az1.id
  }

  tags   = {
    Name = "private_rt_az1"
  }
}

# associate private subnet az1 with private route table az1
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private_app_subnet_az1_route_table_az1_association" {
  subnet_id         = var.private_subnet_az1_id
  route_table_id    = aws_route_table.private_route_table_az1.id
}

# create private route table az2 and add route through nat gateway az1
# terraform aws create route table
resource "aws_route_table" "private_route_table_az2" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_gateway_az1.id
  }

  tags   = {
    Name = "private_rt_az2"
  }
}

# associate private subnet az2 with private route table az2
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private_app_subnet_az2_route_table_az2_association" {
  subnet_id         = var.private_subnet_az2_id
  route_table_id    = aws_route_table.private_route_table_az2.id
}
