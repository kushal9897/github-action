resource "aws_instance" "thiss55" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = var.name
    Team = var.team
  }
}
