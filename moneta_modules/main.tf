module "dbx" {

  source = "./dbx"

  user_groups   = var.user_groups
  clusters      = var.clusters
  users         = var.users
  secret_scopes = var.secret_scopes

}

module "aws" {

  source = "./aws"

  # s3_bucket = var.s3_bucket
  # s3_bucket_v2 = var.s3_bucket_v2
  for_each = { for i in var.s3_bucket_policy : i.bucket_name => i.statements }

  bucket_name = each.key
  s3_bucket   = each.value

}
