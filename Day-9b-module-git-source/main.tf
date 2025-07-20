module "project" {
   source = "github.com/sohailkhan5666/Terraform/Day-3-configfiles"
   ami_id = "ami-0150ccaf51ab55a51"
   instance_type = "t2.micro"
}
