
#Creating user and attaching policy
resource "aws_iam_user" "terrasooraj" {
    name = "terrasooraj"
    path = "/system/"

    tags = {
        Name = "terrasooraj"
    }
}

resource "aws_iam_access_key" "terrasooraj" {
    user = aws_iam_user.terrasooraj.id
}

resource "aws_iam_user_policy" "tfpolicy" {
    name = "tfpolicy"
    user = aws_iam_user.terrasooraj.id
  
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "ec2:Describe*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
}
EOF
}

#Role
resource "aws_iam_role" "sooraj_role" {
  name = "test-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "sooraj_policy" {
  name        = "test-policy"
  description = "A test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.sooraj_role.id
  policy_arn = aws_iam_policy.sooraj_policy.arn
}

#EC2 instance profile
resource "aws_iam_instance_profile" "sooraj_profile" {
  name = "terra-profile"
  role = "${aws_iam_role.sooraj_role.id}"
}
