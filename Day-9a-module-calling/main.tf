module "project" {
   source = "../Day-9-modules"
   ami_id = "ami-0150ccaf51ab55a51"
   instance_type = "t2.micro"
   az = "us-east-1a"
}
