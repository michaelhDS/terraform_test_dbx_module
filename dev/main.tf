
provider "aws" {
  region = "eu-central-1"
}

provider "databricks" {
  # DS
  # host  = "https://dbc-8c8038b8-0e28.cloud.databricks.com"
  # token = "dapi41cd7e0b12ed6d43e9183d62513335c6"

  # MMB
  host  = "https://moneta-e2-databricks-dev.cloud.databricks.com/ "
  token = "dapi04ffa63269d8caddba7beaba57e05467"
}

terraform {
  backend "local" {}

  required_providers {
    databricks = {
      source = "databrickslabs/databricks"
    }
  }
}

module "buckets" {
  source = "./aws/s3"
}

variable "clusters" {

  type = list(object({
    cluster_name     = string
    min_workers      = number
    max_workers      = number
    permission_level = string
    user_group       = string
  }))
  default = [
    {
      cluster_name     = "lyzari"
      min_workers      = 1
      max_workers      = 2
      permission_level = "CAN_ATTACH_TO"
      user_group       = "lyzari"
    }
  ]

}




module "moneta_modules" {

  source = "../moneta_modules"

  # s3_policy = module.buckets.bucket_mmb-test1-mh


  # user_groups = [
  #   {
  #     display_name               = "lyzari"
  #     allow_cluster_create       = true
  #     allow_instance_pool_create = true
  #   }
  # ]

  # users = [
  #   {
  #     user_email     = "lyzar1@moneta.cz"
  #     solution_group = "lyzari"
  # }]

  # clusters = [
  #   for i in var.clusters : i

  # ]

  # secret_scopes = [
  #   {
  #     name = "lyzari"
  #   }
  # ]

  s3_bucket_policy = [
    { bucket_name = "monorepo-testing2-mh"
      statements = [
        {
          statement = {
            sid    = "lyzari1"
            effect = "Allow"

            resources = [
              "arn:aws:s3:::monorepo-testing2-mh/test2/*",
              "arn:aws:s3:::monorepo-testing2-mh/test2",
            ]

            actions = ["s3:GetObject"]

            principals_identifiers = [
              "arn:aws:iam::554025156005:role/testing-monorepo-mh"
            ]
          }
        },
        {
          statement = {
            sid    = "lyzari2"
            effect = "Allow"

            resources = [
              "arn:aws:s3:::monorepo-testing2-mh/test/*",
              "arn:aws:s3:::monorepo-testing2-mh/test",
            ]

            actions = ["s3:GetObject"]

            principals_identifiers = [
              "arn:aws:iam::554025156005:role/testing-monorepo-mh"
            ]
          }
        }

      ]
    },

    {
      bucket_name = "monorepo-testing3-mh"
      statements = [
        {
          statement = {
            sid    = "testing3-lyzari1"
            effect = "Allow"

            resources = [
              "arn:aws:s3:::monorepo-testing3-mh/test2/*",
              "arn:aws:s3:::monorepo-testing3-mh/test2",
            ]

            actions = ["s3:GetObject"]

            principals_identifiers = [
              "arn:aws:iam::554025156005:role/testing-monorepo-mh"
            ]
          }
        },
        {
          statement = {
            sid    = "testing3-lyzari2"
            effect = "Allow"

            resources = [
              "arn:aws:s3:::monorepo-testing3-mh/test/*",
              "arn:aws:s3:::monorepo-testing3-mh/test",
            ]

            actions = ["s3:GetObject"]

            principals_identifiers = [
              "arn:aws:iam::554025156005:role/testing-monorepo-mh"
            ]
          }
        }

      ]

    },



    {
      bucket_name = "monorepo-testing4-mh"
      statements = [
        {
          statement = {
            sid    = "testing4-lyzari1"
            effect = "Allow"

            resources = [
              "arn:aws:s3:::monorepo-testing4-mh/test2/*",
              "arn:aws:s3:::monorepo-testing4-mh/test2",
            ]

            actions = ["s3:GetObject"]

            principals_identifiers = [
              "arn:aws:iam::554025156005:role/testing-monorepo-mh"
            ]
          }
        },
        {
          statement = {
            sid    = "testing4-lyzari2"
            effect = "Allow"

            resources = [
              "arn:aws:s3:::monorepo-testing4-mh/test/*",
              "arn:aws:s3:::monorepo-testing4-mh/test",
            ]

            actions = ["s3:GetObject"]

            principals_identifiers = [
              "arn:aws:iam::554025156005:role/testing-monorepo-mh"
            ]
          }
        }

      ]

    }


  ]


  # s3_bucket = [{
  #   bucket_name = "dtldev-lyzari-xxw"
  #   statement = {
  #     sid    = "lyzari1"
  #     effect = "Allow"

  #     resources = [
  #       "arn:aws:s3:::dtldev-lyzari-xxw/lyzari1/*",
  #       "arn:aws:s3:::dtldev-lyzari-xxw/lyzari1",
  #     ]

  #     actions = ["s3:GetObject"]

  #     principals_identifiers = [
  #       "arn:aws:iam::029825596798:role/slr_dbx_dtldev_general-DTL"
  #     ]
  #   }
  #   }
  # ]

  # s3_bucket_v2 = [{
  #   bucket_name = "dtldev-lyzari-xxw"
  #   statemenst = [{
  #     statement = {
  #       sid    = "lyzari1"
  #       effect = "Allow"

  #       resources = [
  #         "arn:aws:s3:::dtldev-lyzari-xxw/lyzari1/*",
  #         "arn:aws:s3:::dtldev-lyzari-xxw/lyzari1",
  #       ]

  #       actions = ["s3:GetObject"]

  #       principals_identifiers = [
  #         "arn:aws:iam::029825596798:role/slr_dbx_dtldev_general-DTL"
  #       ]
  #     },
  #     statement = {
  #       sid    = "lyzari2"
  #       effect = "Allow"

  #       resources = [
  #         "arn:aws:s3:::dtldev-lyzari-xxw/lyzari2/*",
  #         "arn:aws:s3:::dtldev-lyzari-xxw/lyzari2",
  #       ]

  #       actions = ["s3:GetObject"]

  #       principals_identifiers = [
  #         "arn:aws:iam::029825596798:role/slr_dbx_dtldev_general-DTL"
  #       ]
  #     },

  #   }]
  # }
  # ]



  # s3_bucket = [{
  #   bucket_name = "dtldev-lyzari-xxw"
  #   statements = [{
  #     statement = {
  #       sid    = "lyzari1"
  #       effect = "Allow"

  #       resources = [
  #         "arn:aws:s3:::dtldev-lyzari-xxw/lyzari1/*",
  #         "arn:aws:s3:::dtldev-lyzari-xxw/lyzari1",
  #       ]

  #       actions = ["s3:GetObject"]

  #       principals = {
  #         type = "AWS"

  #         identifiers = [
  #           "arn:aws:iam::029825596798:instance-profile/DataLakeIAMRolesStack-slrdbxdtldevgeneralDTLInstanceProfile-LDB1UYJDP8WH"
  #         ]
  #       }
  #     }
  #   }]
  #   }
  # ]


}
# users = [
#   {
#     user_email     = "m33@mail.cz"
#     solution_group = "m33"
#   },
#   {
#     user_email     = "m1@mail.cz"
#     solution_group = "m1"
#   },
#   {
#     user_email     = "m44@mail.cz"
#     solution_group = "m44"
#   },

# ]

# clusters = [
#   {
#     cluster_name     = "m-test1"
#     min_workers      = 1
#     max_workers      = 2
#     permission_level = "CAN_ATTACH_TO"
#     user_group       = "m1"
#   },
#   {
#     cluster_name     = "m-test22"
#     min_workers      = 3
#     max_workers      = 8
#     permission_level = "CAN_RESTART"
#     user_group       = "m33"
#   },
#   {
#     cluster_name     = "m-test44"
#     min_workers      = 3
#     max_workers      = 6
#     permission_level = "CAN_RESTART"
#     user_group       = "m33"
#   }
# ]

# secret_scopes = [
#   {
#     name = "ms1"
#   }
# ]

# s3_bucket = [{
#   bucket_name = "mmb-test1-mh"
#   statements = [{
#     statement = {
#       sid    = "mm33"
#       effect = "Allow"

#       resources = [
#         "arn:aws:s3:::mmb-test1-mh/snowboardsteam_path/*",
#         "arn:aws:s3:::mmb-test1-mh/snowboardsteam_path",
#       ]

#       actions = ["s3:*"]

#       principals = {
#         type = "AWS"

#         identifiers = [
#           "arn:aws:iam::554025156005:role/snowboardsteamApp",
#           "arn:aws:iam::554025156005:user/snowboardsteam",
#         ]
#       }
#     }
#   }]

# }]

#   [
#     {

# bucket_name = "mmb-test1-mh"
# statements = [{


#     }

# ]


