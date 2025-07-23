resource "aws_instance" "name" {
  ami = "ami-0cbbe2c6a1bb2ad63"
  instance_type = "t2.micro"
  tags = {
    Name = "test"
  }

#  lifecycle {
#    prevent_destroy = true
#  }

#  lifecycle {
#    ignore_changes = [tags]
#  }

  lifecycle {
    create_before_destroy = true
 }

}
