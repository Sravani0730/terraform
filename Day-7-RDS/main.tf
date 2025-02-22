resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  db_subnet_group_name   = aws_db_subnet_group.sub-grp.id
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "devops123"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "sub-grp" {
  name       = "main"
  subnet_ids = ["subnet-033e507a1dc5cc271","subnet-05c359ffb8ef03006"]

  tags = {
    Name = "My DB subnet group"
  }
}