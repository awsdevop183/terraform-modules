resource "aws_instance" "testvm" {
  ami           = var.ami
  instance_type = var.instance-type
  subnet_id     = var.subnet_id
  key_name      = aws_key_pair.key.key_name
  vpc_security_group_ids = [var.sg]

  tags = {
    Name = "${var.vpc-name}-VM"
  }

    user_data = <<-EOF
      #!/bin/bash
      apt update -y
      apt install nginx -y
      cd /var/www/html
      echo "<html><h1>Welcome to Terraform Zero to Hero @${var.vpc-name} Instance </h1></html>" > index.html
    EOF

}
