resource "aws_instance" "ec2" {
  ami = "ami-0cbbe2c6a1bb2ad63"
  instance_type = "t2.micro"
  user_data = file("test.sh")
}

