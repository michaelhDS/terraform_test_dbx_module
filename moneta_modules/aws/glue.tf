variable "glue_policy" {
  type = list(object({
    actions    = list(string)
    resources  = list(string)
    principals = list(string)
  }))

  default = [
    {
      actions    = ["glue:GetDatabase", "glue:GetTable"]
      resources  = ["arn:aws:glue:eu-central-1:029825596798:database/ads_test"]
      principals = ["arn:aws:iam::029825596798:role/slr_dbx_dtldevsolution_group_demo"]
    }
  ]

}

locals {
  data_combine_glue = [for i in data.aws_iam_policy_document.glue_policy : i.json]
}

data "aws_iam_policy_document" "combined_glue" {
  source_policy_documents = local.data_combine_glue
}


data "aws_iam_policy_document" "glue_policy" {

  count = length(var.glue_policy)

  statement {
    actions   = var.glue_policy[count.index].actions
    resources = var.glue_policy[count.index].resources
    principals {
      identifiers = var.glue_policy[count.index].principals
      type        = "AWS"
    }
  }
}

resource "aws_glue_resource_policy" "glue_policy" {
  policy = data.aws_iam_policy_document.combined_glue.json
}
