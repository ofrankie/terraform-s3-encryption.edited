data "aws_caller_identity" "current" {}

resource "aws_kms_key" "dev-desecurebucket" {
  deletion_window_in_days = 7
  tags                    = "${merge(map("Name", "${var.dev-base_name}"), var.tags)}"
  description             = "Key for Encryption in S3 for dev-desecurebucket"

  policy = <<Policy
{
  "Version": "2012-10-17",
  "Id": "${var.dev-base_name}",
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

resource "aws_kms_alias" "dev-desecurebucket" {
  name          = "alias/dev-desecurebucket"
  target_key_id = "${aws_kms_key.dev-desecurebucket.id}"
}


resource "aws_kms_key" "qa-desecurebucket" {
  deletion_window_in_days = 7
  tags                    = "${merge(map("Name", "${var.qa-base_name}"), var.tags)}"
  description             = "Key for Encryption in S3 for qa-desecurebucket"

  policy = <<Policy
{
  "Version": "2012-10-17",
  "Id": "${var.qa-base_name}",
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

resource "aws_kms_alias" "qa-desecurebucket" {
  name          = "alias/qa-desecurebucket"
  target_key_id = "${aws_kms_key.qa-desecurebucket.id}"
}


resource "aws_kms_key" "prod-desecurebucket" {
  deletion_window_in_days = 7
  tags                    = "${merge(map("Name", "${var.prod-base_name}"), var.tags)}"
  description             = "Key for Encryption in S3 for prod-desecurebucket"

  policy = <<Policy
{
  "Version": "2012-10-17",
  "Id": "${var.prod-base_name}",
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

resource "aws_kms_alias" "prod-desecurebucket" {
  name          = "alias/prod-desecurebucket"
  target_key_id = "${aws_kms_key.prod-desecurebucket.id}"
}