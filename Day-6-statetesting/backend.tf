terraform {
#required_version = ">=1.10" # this will allow to work same terraform version only 
  backend "s3" {
    bucket = "pojdfpoajh"
    key    = "terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true #supports latest version >=1.10
    #dynamodb_table = "sohail"
    #encrypt = false
  }
}
