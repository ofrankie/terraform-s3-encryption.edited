data "aws_caller_identity" "current" {}

resource "aws_kms_key" "desecurebucket" {
  deletion_window_in_days = 7
  tags                    = "${merge(map("Name", "${var.base_name}"), var.tags)}"
  description             = "Key for Encryption in S3 for desecurebucket"

  policy = <<Policy
{
  "Version": "2012-10-17",
  "Id": "${var.base_name}",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
Policy
}

resource "aws_kms_alias" "desecurebucket" {
  name          = "alias/desecurebucket"
  target_key_id = "${aws_kms_key.desecurebucket.id}"
}
