resource "aws_iam_user" "IAMUser" {
    path = "/"
    name = "${var.generic_user}"
    tags = {}
}

resource "aws_iam_access_key" "IAMUser" {
  user = aws_iam_user.IAMUser.name
}

resource "aws_iam_user_group_membership" "user_membership" {
  user   = aws_iam_user.IAMUser.name
  groups = [aws_iam_group.IAMGroup.name]
}
