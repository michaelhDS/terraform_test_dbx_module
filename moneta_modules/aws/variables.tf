variable "bucket_name" {
  type    = string
  default = ""
}

variable "s3_bucket" {

  type = list(object({
    statement = object({
      sid                    = string
      effect                 = string
      resources              = list(string)
      actions                = list(string)
      principals_identifiers = list(string)
    })
  }))

  default = []

}



variable "arn" {
  type    = list(string)
  default = ["arn:aws:s3:::mmb-test1-mh/snowboardsteam_path", "arn:aws:s3:::mmb-test1-mh/snowboardsteam_path/*"]
}

variable "actions" {
  type    = list(string)
  default = ["s3:*"]
}

variable "user" {
  type    = list(string)
  default = ["arn:aws:iam::554025156005:user/snowboardsteam", "arn:aws:iam::554025156005:role/snowboardsteamApp"]
}

# variable "s3_bucket" {

#   type = list(object({
#     bucket_name = string
#     statement = object({
#       sid                    = string
#       effect                 = string
#       resources              = list(string)
#       actions                = list(string)
#       principals_identifiers = list(string)

#     })

#   }))

#   default = []
# }


# variable "s3_bucket_v2" {

#   type = list(object({
#     bucket_name = string
#     statemenst = list(object({
#       statement = object({
#         sid                    = string
#         effect                 = string
#         resources              = list(string)
#         actions                = list(string)
#         principals_identifiers = list(string)

#       })
#     }))


#   }))

#   default = []
# }


locals {
  # buckets_name            = [for i in var.s3_bucket : i.bucket_name]
  # buckets_name_statements = { for i in var.s3_bucket : i.bucket_name => i.statement }
  # buckets_name_principals_identifiers = { for i in var.s3_bucket : i.bucket_name => i.principals_identifiers }

  # buckets_name_v2 = [for i in var.s3_bucket_v2 : i.bucket_name]

  # statements = { for i in var.s3_bucket_v2 : i.bucket_name => i.statemenst }

  #  # Nested loop over both lists, and flatten the result.
  # buckets_name_statements_v2 = distinct(flatten([
  #   for schema in local.schemas : [
  #     for privilege in local.privileges : {
  #       privilege = privilege
  #       schema    = schema
  #     }
  #   ]
  # ]))

  # buckets_name_statements_v2 = { for i in var.s3_bucket_v2 : i.bucket_name => i.statemenst }

  # buckets_name_sid                    = { for i in var.s3_bucket : i.bucket_name => i.sid }
  # buckets_name_effect                 = { for i in var.s3_bucket : i.bucket_name => i.effect }
  # buckets_name_resources              = { for i in var.s3_bucket : i.bucket_name => i.resources }
  # buckets_name_actions                = { for i in var.s3_bucket : i.bucket_name => i.actions }
  # buckets_name_principals_identifiers = { for i in var.s3_bucket : i.bucket_name => i.principals_identifiers }
}


