resource "aws_instance" "nginx-uk" {
  ami           = var.ami
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = var.subnet_uk

  tags = {
    Name = "nginx-uk"
  }

  user_data = file("scripts/init_uk.sh")
}

resource "aws_instance" "nginx-global" {
  ami           = var.ami
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = var.subnet_global

  tags = {
    Name = "nginx-global"
  }

  user_data = file("scripts/init_global.sh")
}