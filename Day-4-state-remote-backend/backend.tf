terraform {
  backend "s3" {
    bucket = "terraforms3practice"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
