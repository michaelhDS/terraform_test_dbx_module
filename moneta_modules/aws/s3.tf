

locals {
  data_combine_s3 = [for i in data.aws_iam_policy_document.bucket_policy : i.json]
}


data "aws_iam_policy_document" "bucket_policy" {

  count = length(var.s3_bucket)

  statement {
    sid       = var.s3_bucket[count.index].statement.sid
    effect    = var.s3_bucket[count.index].statement.effect
    resources = var.s3_bucket[count.index].statement.resources
    actions   = var.s3_bucket[count.index].statement.actions

    principals {
      type        = "AWS"
      identifiers = var.s3_bucket[count.index].statement.principals_identifiers
    }
  }
}

data "aws_iam_policy_document" "combined_s3" {
  source_policy_documents = local.data_combine_s3
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = var.bucket_name
  policy = data.aws_iam_policy_document.combined_s3.json
}











# resource "aws_s3_bucket_policy" "bucket_policy" {
#   # for_each = toset(local.sid)
#   for_each = toset(local.buckets_name)

#   bucket = each.value
#   policy = data.aws_iam_policy_document.bucket_policy[each.key].json
# }

# data "aws_iam_policy_document" "bucket_policy" {

#   for_each = toset(local.buckets_name)


#   statement {
#     sid       = local.buckets_name_statements[each.key].sid
#     effect    = local.buckets_name_statements[each.key].effect
#     resources = local.buckets_name_statements[each.key].resources
#     actions   = local.buckets_name_statements[each.key].actions

#     principals {
#       type        = "AWS"
#       identifiers = local.buckets_name_statements[each.key].principals_identifiers
#     }
#   }
# }

# data "aws_iam_policy_document" "combined" {
#   for_each = toset(local.sid)

#   source_policy_documents = [
#     data.aws_iam_policy_document.bucket_policy[each.key].json
#   ]
# }

# variable "policy" {

#   type = list(object({
#     bucket_name = string
#     policies = list(object({
#       sid                    = string
#       effect                 = string
#       actions                = list(string)
#       resources              = list(string)
#       principals_identifiers = list(string)
#     }))

#   }))
#   default = [
#     {
#       bucket_name = "mmb-test1-mh"
#       policies = [{
#         sid     = "mm33"
#         effect  = "Allow"
#         actions = ["s3:PutObject"]
#         resources = [
#           "arn:aws:s3:::mmb-test1-mh/snowboardsteam_path/*",
#           "arn:aws:s3:::mmb-test1-mh/snowboardsteam_path",
#         ]
#         principals_identifiers = [
#           "arn:aws:iam::554025156005:role/snowboardsteamApp",
#           "arn:aws:iam::554025156005:user/snowboardsteam",
#         ]
#       }]

#     }
#     # ,
#     # {
#     #   bucket_name = "mmb-test1-mh"
#     #   sid         = "x43"
#     #   effect      = "Allow"
#     #   actions     = ["s3:PutObject"]
#     #   resources = [
#     #     "arn:aws:s3:::mmb-test1-mh/snowboardsteam_path/*",
#     #     "arn:aws:s3:::mmb-test1-mh/snowboardsteam_path",
#     #   ]
#     #   principals_identifiers = [
#     #     "arn:aws:iam::554025156005:role/lyzari-app",
#     #     "arn:aws:iam::554025156005:user/lyzari",
#     #   ]
#     # }
#   ]
# }

# # output "bucket_policy" {
# #   value = data.aws_iam_policy_document.bucket_policy.json
# # }

# locals {
#   bucket_name          = [for i in var.policy : i.bucket_name]
#   bucket_name_policies = { for i in var.policy : i.bucket_name => i.policies }





#   sid             = [for i in var.policy : i.sid]
#   sid_bucket_name = { for i in var.policy : i.sid => i.bucket_name }
#   sid_effect      = { for i in var.policy : i.sid => i.effect }
#   sid_resources   = { for i in var.policy : i.sid => i.resources }

#   sid_actions                = { for i in var.policy : i.sid => i.actions }
#   sid_principals_identifiers = { for i in var.policy : i.sid => i.principals_identifiers }

# }


# data "aws_iam_policy_document" "bucket_policy" {

#   for_each = toset(local.bucket_name)


#   statement {
#     sid       = local.bucket_name_policies.sid[each.key]
#     effect    = local.bucket_name_policies.effect[each.key]
#     resources = local.bucket_name_policies.resources[each.key]
#     actions   = local.bucket_name_policies.actions[each.key]

#     principals {
#       type = "AWS"

#       identifiers = local.bucket_name_policies.principals_identifiers[each.key]
#     }
#   }
# }




# data "aws_iam_policy_document" "combined" {
#   source_policy_documents = [
#     data.aws_iam_policy_document.bucket_policy.json,
#     data.aws_iam_policy_document.original.json
#   ]
# }

# data "aws_iam_policy_document" "original" {
#   statement {
#     sid    = "origin-test"
#     effect = "Allow"

#     resources = [
#       "arn:aws:s3:::mmb-test1-mh/lyzar/*",
#       "arn:aws:s3:::mmb-test1-mh/lyzar",
#     ]

#     actions = ["s3:*"]

#     principals {
#       type = "AWS"

#       identifiers = [
#         "arn:aws:iam::554025156005:role/lyzari-app",
#         "arn:aws:iam::554025156005:user/lyzari",
#       ]
#     }
#   }
# }
