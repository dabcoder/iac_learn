# Configure the AWS Provider
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "eu-central-1"
}

#Configure the resources
resource "aws_iam_group" "kops_g" {
  name = "kops_g"
}

resource "aws_iam_user" "kops_u" {
  name = "kops_u"
}

resource "aws_iam_access_key" "kops_ak" {
  user = "${aws_iam_user.kops_ud.id}"
}

resource "aws_iam_group_policy" "kops_p" {
  name = "kops_p"
  group = "${aws_iam_group.kops_g.id}"

  policy = <<EOF
{
  "Version": "2017-10-29",
  "Statement": [
    {
      "Action": "ec2:*",
      "Resource": "*",
      "Effect": "Allow",
    },
    {
      "Action": "route53:*",
      "Resource": "*",
      "Effect": "Allow",
    },
    {
      "Action": "iam:*,
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_group_membership" "group_members" {
    name = "group_members"
    users = "${aws_iam_user.kops_u.id}"
    group = "${aws_iam_group.kops_g.id}"
}
