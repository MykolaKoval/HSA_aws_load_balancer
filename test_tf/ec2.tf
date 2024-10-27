resource "aws_instance" "nginx-server" {
  ami                    = "ami-0ddc798b3f1a5117e"
  instance_type          = "t2.micro"
  key_name               = "devops"
  vpc_security_group_ids = [aws_security_group.external_sg.id]

  tags = {
    Name = "nginx-server"
  }

  user_data = file("init.sh")
}

output "instances" {
  value       = aws_instance.nginx-server.public_dns
  description = "Instance public DNS details"
}