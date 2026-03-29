output "subnet-id" {
    value = aws_subnet.public-sub-1.id
  
}
output "sg" {
    value = aws_security_group.default.id
  
}