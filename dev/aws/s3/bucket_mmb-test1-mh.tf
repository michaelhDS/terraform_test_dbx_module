# data "aws_iam_policy_document" "bucket_policy" {

#   statement {
#     sid    = "mm33"
#     effect = "Allow"

#     resources = [
#       "arn:aws:s3:::mmb-test1-mh/snowboardsteam_path/*",
#       "arn:aws:s3:::mmb-test1-mh/snowboardsteam_path",
#     ]

#     actions = ["s3:*"]

#     principals {
#       type = "AWS"

#       identifiers = [
#         "arn:aws:iam::554025156005:role/snowboardsteamApp",
#         "arn:aws:iam::554025156005:user/snowboardsteam",
#       ]
#     }
#   }
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
#         "arn:aws:iam::554025156005:user/lyzari",
#         "arn:aws:iam::554025156005:role/lyzari-app",
#       ]
#     }
#   }
# }
