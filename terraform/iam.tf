resource "aws_iam_policy" "db" {
    name = "${module.naming.aws_iam_policy}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "rds-db:connect"
            ],
            "Resource": [
                "arn:aws:rds-db:<region>:<account-id>:dbuser:<DbiResourceId>/<db_user_name>"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "db" {
    role = "${module.public-lambda-api.iam_role}"
    policy_arn = "${aws_iam_policy.db.arn}"
}