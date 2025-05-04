#create a security group for the public instance
# terraform aws create security group
resource "aws_security_group" "jump_host_security_group" {
  name        = "jump-host-SG"
  description = "Allow SSH to jump server"
  vpc_id      = aws_vpc.patty_moore_vpc.id
  ingress {
    description = "Allow SSH to jump server"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["102.89.32.214/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jump-host-SG"
  }
}

#create security group for private instance
resource "aws_security_group" "private_instance_SG" {
  name        = "private_instance_SG"
  description = "Allow SSH access from jump host"
  vpc_id      = aws_vpc.patty_moore_vpc.id
  ingress {
    description = "Allow SSH access from jump host"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.jump_host_security_group.id]
  }

ingress {
    description = "Allow SSH access from jump host"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private_instance_SG"
  }
}
