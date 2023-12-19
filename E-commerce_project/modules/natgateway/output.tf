output "nat_gateway_az1_id" {
  value = aws_nat_gateway.nat_gateway_az1.id
}
output "private_route_table_az1_id" {
  value = aws_route_table.private_route_table_az1.id
}

output "private_route_table_az2_id" {
  value = aws_route_table.private_route_table_az2.id
}
