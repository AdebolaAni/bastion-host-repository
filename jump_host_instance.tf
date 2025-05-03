#This is to create an instance in a public subnet
resource "aws_instance" "jump_host_instance" {
  ami                         = "ami-07a6f770277670015"
  instance_type               = "t2.micro"
  key_name                    = "debson_keypair" 
  subnet_id                   = aws_subnet.patty_moore_public_subnet_az1a.id
  vpc_security_group_ids      = [aws_security_group.jump_host_security_group.id]
  associate_public_ip_address = true

  tags = {
    Name = "jump_host_instance"
  }
} 

#This is to create an instance in a private subnet
resource "aws_instance" "patty_moore_web_server" {
  ami                         = "ami-07a6f770277670015"
  instance_type               = "t2.micro"
  key_name                    = "debson_keypair" 
  subnet_id                   = aws_subnet.patty_moore_private_app_subnet_az1a.id
  vpc_security_group_ids      = [aws_security_group.private_instance_SG]
  associate_public_ip_address = false

  tags = {
    Name = "patty_moore_web_server"
  }
} 