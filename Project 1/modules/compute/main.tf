#Create Securtiy Group for Ec2 
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH traffic"
  vpc_id      = var.vpc-id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Create First EC2
resource "aws_instance" "Global-Base-AMI-ec2" {
  ami           = data.aws_ami.Amazon-linux-ami.id
  instance_type = var.aws-ec2-type
  key_name      = var.aws-key-name
  vpc_security_group_ids = [ aws_security_group.allow_ssh.id ]
  subnet_id = var.public-subnet-id
  tags = {
    Name = "Globa-Base-AMI-ec2"
  }

  provisioner "file" {
    source =  "~/Scripts/Global_AMI.sh"
    destination = "/tmp/Global_AMI.sh"

  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/Global_AMI.sh",
      "sudo /tmp/Global_AMI.sh"

    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("~/Downloads/Project1_Key.pem")
    timeout = "5m"
  }
}

#Create AMI from First Ec2
resource "aws_ami_from_instance" "Global-Base_AMI"{
  name = "Global-Base-AMI"
  source_instance_id = aws_instance.Global-Base-AMI-ec2.id
  description = "Custom AMI created to be used in other EC2"
}