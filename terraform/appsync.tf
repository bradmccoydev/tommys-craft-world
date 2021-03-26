# ---------------------------------------------------------------------------------------------------------------------
# AppSync GraphQL API
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_appsync_graphql_api" "main" {
  name                = "${var.application_name}-api"
  authentication_type = "AWS_IAM"

  additional_authentication_provider {
    authentication_type = "API_KEY"
  }

  user_pool_config {
    user_pool_id   = aws_cognito_user_pool.main.id
    aws_region     = var.aws_region
    default_action = "ALLOW"
  }

  log_config {
    cloudwatch_logs_role_arn = aws_iam_role.appsync.arn
    field_log_level          = "ERROR"
  }


  schema = file("./../src/api/schema.graphql")
}

resource "aws_appsync_api_key" "key" {
  api_id  = aws_appsync_graphql_api.main.id
}

# ---------------------------------------------------------------------------------------------------------------------
# Data Sources
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_appsync_datasource" "application" {
  name             = "OrderTable"
  api_id           = aws_appsync_graphql_api.main.id
  service_role_arn = aws_iam_role.appsync.arn
  type             = "AMAZON_DYNAMODB"

  dynamodb_config {
    table_name = aws_dynamodb_table.orders.name
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Resolvers
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_appsync_resolver" "get_application_metadata_registry" {
  api_id            = aws_appsync_graphql_api.main.id
  field             = "getOrder"
  type              = "Query"
  data_source       = aws_appsync_datasource.orders.name
  request_template  = file("./../src/api/resolvers/Query.getOrder.req.vtl")
  response_template = <<EOF
  $util.toJson($ctx.result)
  EOF
}

resource "aws_appsync_resolver" "list_application_metadata_registry" {
  api_id            = aws_appsync_graphql_api.main.id
  field             = "listOrder"
  type              = "Query"
  data_source       = aws_appsync_datasource.orders.name
  request_template  = file("./../src/api/resolvers/Query.listOrder.req.vtl")
  response_template = <<EOF
  $util.toJson($ctx.result)
  EOF
}

resource "aws_appsync_resolver" "create_application_metadata" {
  api_id            = aws_appsync_graphql_api.main.id
  field             = "createOrder"
  type              = "Mutation"
  data_source       = aws_appsync_datasource.orders.name
  request_template  = file("./../src/api/resolvers/Mutation.createOrder.req.vtl")
  response_template = <<EOF
  $util.toJson($ctx.result)
  EOF
}

resource "aws_appsync_resolver" "update_application_metadata" {
  api_id            = aws_appsync_graphql_api.main.id
  field             = "updateOrder"
  type              = "Mutation"
  data_source       = aws_appsync_datasource.orders.name
  request_template  = file("./../src/api/resolvers/Mutation.updateOrder.req.vtl")
  response_template = <<EOF
  $util.toJson($ctx.result)
  EOF
}

resource "aws_appsync_resolver" "delete_application_metadata" {
  api_id            = aws_appsync_graphql_api.main.id
  field             = "deleteOrder"
  type              = "Mutation"
  data_source       = aws_appsync_datasource.orders.name
  request_template  = file("./../src/api/resolvers/Mutation.deleteOrder.req.vtl")
  response_template = <<EOF
  $util.toJson($ctx.result)
  EOF
}