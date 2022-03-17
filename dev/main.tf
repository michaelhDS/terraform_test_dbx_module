
provider "aws" {
  region = "eu-central-1"
}

provider "databricks" {
  host  = "https://dbc-8c8038b8-0e28.cloud.databricks.com"
  token = "dapi41cd7e0b12ed6d43e9183d62513335c6"
}

terraform {
  backend "local" {}

  required_providers {
    databricks = {
      source = "databrickslabs/databricks"
    }
  }
}

module "moneta_modules" {

  source = "github.com/michaelhDS/tf_mmb_module_dev.git"

  user_groups = [
    {
      display_name               = "m1"
      allow_cluster_create       = true
      allow_instance_pool_create = true
    },
    {
      display_name               = "m33"
      allow_cluster_create       = false
      allow_instance_pool_create = true
    },
    {
      display_name               = "m44"
      allow_cluster_create       = true
      allow_instance_pool_create = true
    }

  ]

  users = [
    {
      user_email     = "m33@mail.cz"
      solution_group = "m33"
    },
    {
      user_email     = "m1@mail.cz"
      solution_group = "m1"
    },
    {
      user_email     = "m44@mail.cz"
      solution_group = "m44"
    },

  ]

  clusters = [
    {
      cluster_name     = "m-test1"
      min_workers      = 1
      max_workers      = 2
      permission_level = "CAN_ATTACH_TO"
      user_group       = "m1"
    },
    {
      cluster_name     = "m-test22"
      min_workers      = 3
      max_workers      = 8
      permission_level = "CAN_RESTART"
      user_group       = "m33"
    },
    {
      cluster_name     = "m-test44"
      min_workers      = 3
      max_workers      = 6
      permission_level = "CAN_RESTART"
      user_group       = "m33"
    }
  ]

  # secret_scopes = [
  #   {
  #     name = "ms1"
  #   }
  # ]


}
