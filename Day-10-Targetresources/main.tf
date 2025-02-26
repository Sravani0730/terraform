provider "aws" { 
    region = "ap-south-1"
}

resource "aws_instance" "dependent" {
    ami = "ami-0d682f26195e9ec0f"
    instance_type = "t2.micro"
    key_name = "public"
}

resource "aws_s3_bucket" "dependent" {
    bucket = "abcdefghithy" 
}

#terraform apply -target=aws_s3_bucket.dependent
#terraform destroy -target=aws_s3_bucket.dependent
