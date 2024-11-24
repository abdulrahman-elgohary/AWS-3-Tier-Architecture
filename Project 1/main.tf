
module "networking" {
  source = "./modules/networking"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidr = "10.0.0.0/24"
  availability_zone = "us-east-1a"
}


module "compute" {
  source = "./modules/compute"
  aws-ec2-type = "t2.micro"
  aws-key-name = "Project1_Key"
  vpc-id = module.networking.o-vpc-id
  public-subnet-id = module.networking.o-public-subnet-id
  
}