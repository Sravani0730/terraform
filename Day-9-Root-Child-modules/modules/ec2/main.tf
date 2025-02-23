resource "aws_instance" "this" {
  ami           = "ami-0d682f26195e9ec0f"  # Replace with a valid AMI
  instance_type = var.instance_type

  tags = {
    Name = "Terraform-EC2"
  }
}

