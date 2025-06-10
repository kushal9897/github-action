module "team_aa" {
  source        = "./modules/ec2-instance"
  ami           = var.ami
  instance_type = "t2.micro"
  name          = "team-a-instance"
  team          = "team-a"
}

module "team_b" {
  source        = "./modules/ec2-instance"
  ami           = var.ami
  instance_type = "t2.micro"
  name          = "team-b-instance"
  team          = "team-b"
}
