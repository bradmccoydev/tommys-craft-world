# ---------------------------------------------------------------------------------------------------------------------
# Terraform State
# ---------------------------------------------------------------------------------------------------------------------
terraform {
  backend "s3" {
    bucket         = "terraform.bradmccoy.io"
    key            = "tommyscraftworld/s3/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform_self_service_locks"
    encrypt        = true
  }
}

# resource "aws_dynamodb_table" "terraform_self_service_locks" {
#   name         = "terraform_tommys_craft_world_locks"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"
#   tags     = var.tags
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }