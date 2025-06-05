module "team_a_instance" {
  source        = "../modules/ec2-instance"
  ami           = var.ami
  instance_type = "t2.micro"
  name          = "team-a-instance"
  team          = "team-a"
}
