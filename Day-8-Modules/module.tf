module "dev" {
    source = "../Day-2-basic-code-for-module-source"
    ami_id ="ami-0d682f26195e9ec0f"
    type ="t2.micro"
    key ="mykeypair"
  
}