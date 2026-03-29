resource "aws_security_group" "default" {
  vpc_id = aws_vpc.prod.id
  name   = "${var.vpc-name}-sg"
  tags = {
    Name = "${var.vpc-name}-sg"
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"         #TCP,UDP,ICMP
    cidr_blocks      = ["0.0.0.0/0"] # IPV4
    ipv6_cidr_blocks = ["::/0"]      # IPV6
  }

}