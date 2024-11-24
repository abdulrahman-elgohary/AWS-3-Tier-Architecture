data "aws_ami" "Amazon-linux-ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

variable "aws-ec2-type" {
    type = string
}

variable "aws-key-name" {
    type = string
}

variable "vpc-id" {
  type = string
}

variable "public-subnet-id" {
  type = string 
}