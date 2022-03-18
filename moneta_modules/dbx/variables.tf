variable "user_groups" {
  type = list(object({
    display_name               = string
    allow_cluster_create       = bool
    allow_instance_pool_create = bool
  }))
  default = []
}


variable "clusters" {
  type = list(object({
    cluster_name     = string
    min_workers      = number
    max_workers      = number
    permission_level = string
    user_group       = string

  }))
  default = []
}

variable "secret_scopes" {
  type = list(object({
    name = string
  }))
  default = []
}

variable "users" {
  type = list(object({
    user_email     = string
    solution_group = string

  }))
  default = []
}


locals {
  display_name                            = [for ni in var.user_groups : ni.display_name]
  display_name_allow_cluster_create       = { for ni in var.user_groups : ni.display_name => ni.allow_cluster_create }
  display_name_allow_instance_pool_create = { for ni in var.user_groups : ni.display_name => ni.allow_instance_pool_create }

  user_email                = [for ni in var.users : ni.user_email]
  user_email_solution_group = { for ni in var.users : ni.user_email => ni.solution_group }
}

locals {
  cluster_name                  = [for i in var.clusters : i.cluster_name]
  cluster_name_min_workers      = { for i in var.clusters : i.cluster_name => i.min_workers }
  cluster_name_max_workers      = { for i in var.clusters : i.cluster_name => i.max_workers }
  cluster_name_permission_level = { for i in var.clusters : i.cluster_name => i.permission_level }
  cluster_name_user_group       = { for i in var.clusters : i.cluster_name => i.user_group }

}
