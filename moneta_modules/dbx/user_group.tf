resource "databricks_group" "solution_group" {

  for_each                   = toset(local.display_name)
  display_name               = each.value
  allow_cluster_create       = local.display_name_allow_cluster_create[each.key]
  allow_instance_pool_create = local.display_name_allow_instance_pool_create[each.key]
}


resource "databricks_user" "group_user" {
  for_each  = toset(local.user_email)
  user_name = each.value
}


resource "databricks_group_member" "i-am-admin" {
  for_each = toset(local.user_email)

  group_id  = databricks_group.solution_group[local.user_email_solution_group[each.key]].id
  member_id = databricks_user.group_user[each.value].id
}
