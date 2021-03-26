# ---------------------------------------------------------------------------------------------------------------------
# DynamoDB
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_dynamodb_table" "orders" {
  name           = "orders"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
  range_key      = "version"
  tags = var.tags
    attribute {
    name = "id"
    type = "S"
  }
}