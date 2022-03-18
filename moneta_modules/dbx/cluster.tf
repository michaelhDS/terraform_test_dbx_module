data "databricks_node_type" "smallest" {
  local_disk = true
}

data "databricks_spark_version" "latest_lts" {
  long_term_support = true
}

resource "databricks_cluster" "cluster" {

  for_each = toset(local.cluster_name)


  cluster_name            = each.value
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 10
  autoscale {
    min_workers = local.cluster_name_min_workers[each.key]
    max_workers = local.cluster_name_max_workers[each.key]
  }
}

resource "databricks_permissions" "cluster_usage" {

  for_each   = toset(local.cluster_name)
  cluster_id = databricks_cluster.cluster[each.value].cluster_id

  access_control {
    group_name       = local.cluster_name_user_group[each.key]
    permission_level = local.cluster_name_permission_level[each.key]
  }
}
