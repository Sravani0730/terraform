provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_s3_bucket" "dev" {
  bucket="fghjvbgbv"
}

resource "aws_instance" "dev" {
    ami = "ami-0d682f26195e9ec0f"
    instance_type = "t2.micro"
    key_name = "mykeypair"
    tags = {
        Name = "key-tf"
    }
  
}