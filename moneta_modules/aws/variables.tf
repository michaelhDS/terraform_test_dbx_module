variable "buckets_name" {
  type    = string
  default = "mmb-test1-mh"
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

variable "s3_bucket" {

  type = list(object({
    bucket_name = string
    statements = list(object({
      statement = object({
        sid       = string
        effect    = string
        resources = list(string)
        actions   = list(string)
        principals = object({
          type        = string
          identifiers = list(string)
        })
      })
    }))
  }))

  default = []
}

locals {
  buckets_name            = [for i in var.s3_bucket : i.bucket_name]
  buckets_name_statements = { for i in var.s3_bucket : i.bucket_name => i.statements }

  # buckets_name_sid                    = { for i in var.s3_bucket : i.bucket_name => i.sid }
  # buckets_name_effect                 = { for i in var.s3_bucket : i.bucket_name => i.effect }
  # buckets_name_resources              = { for i in var.s3_bucket : i.bucket_name => i.resources }
  # buckets_name_actions                = { for i in var.s3_bucket : i.bucket_name => i.actions }
  # buckets_name_principals_identifiers = { for i in var.s3_bucket : i.bucket_name => i.principals_identifiers }
}


variable "s3_policy" {
  type    = string
  default = ""
}

