module "team_b_instance" {
  source        = "../modules/ec2-instance"
  ami           = var.ami
  instance_type = "t2.micro"
  name          = "team-b-instance"
  team          = "team-b"
}
