provider "aws" {
  region = var.aws_region
}

resource "aws_iam_group" "developers" {
  name = var.aws_developers
  path = "/users/"
}

resource "aws_iam_group" "UAT" {
  name = var.aws_uat
  path = "/users/"
}

resource "aws_iam_group" "production" {
  name = var.aws_prod
  path = "/users/"
}

# Attach AdministratorAccess to Developers Group
#group = aws_iam_group.developers.name 
resource "aws_iam_group_policy_attachment" "developers_admin" {
  group      = aws_iam_group.developers.name
  policy_arn = var.aws_developers_policy
}

# Attach ReadOnlyAccess to UAT Group
resource "aws_iam_group_policy_attachment" "uat_readonly" {
  group      = aws_iam_group.UAT.name
  policy_arn = var.aws_uat_policy
}

# Attach PowerUserAccess to Production Group
resource "aws_iam_group_policy_attachment" "prod_poweruser" {
  group      = aws_iam_group.production.name
  policy_arn = var.aws_prod_policy
}

resource "aws_iam_user" "developers_users" {
  name = var.aws_dvelopers_users
  path = "/dvelopers/"
  tags = {
    tag-key = var.aws_developers_tag
  }
}

resource "aws_iam_user_group_membership" "developers_attach_group" {
  user = aws_iam_user.developers_users.name
  groups = var.aws_aws_dvelopers_grp
}


