resource "aws_iam_group" "IAMGroup" {
    path = "/"
    name = "VNV_Group"
}

resource "aws_iam_group_policy_attachment" "IAMGroup-attach-policies" {
  count       = length(var.managed_policy_arns_vnv)
  group       = aws_iam_group.IAMGroup.name
  policy_arn  = var.managed_policy_arns_vnv[count.index]
}