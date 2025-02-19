resource "aws_instance" "import" {
  ami = "ami-0ddfba243cbee3768"
  instance_type = "t2.micro"
  key_name = "mykeypair"
  tags = {
    Name = "dev"
  }
}