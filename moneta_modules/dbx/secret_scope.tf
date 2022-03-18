resource "databricks_secret_scope" "this" {
  for_each = { for x in var.secret_scopes : x.name => x }
  name     = each.value.name
}






