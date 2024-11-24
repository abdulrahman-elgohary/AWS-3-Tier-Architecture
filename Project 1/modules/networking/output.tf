output "o-vpc-id" {
  value = aws_vpc.P1_Vpc.id
}

output "o-public-subnet-id" {
    value = aws_subnet.P1_Public_Subnet.id
}