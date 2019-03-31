# ----------------------------------------------------------------------------------------
# our test bucket
# ----------------------------------------------------------------------------------------

resource "aws_s3_bucket" "desecurebucket" {
  bucket_prefix = "${var.base_name}"
  acl           = "private"
  region        = "${var.aws_region}"
  tags          = "${merge(map("Name", "${var.base_name}"), var.tags)}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.desecurebucket.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

#
# Note that this policy allows access from the specified role if it's via the VPC endpoint, but
# does NOT deny access based on other criteria. If your account has principals that are allowed
# broad S3 access, they will still be able to read and write the bucket.
#
resource "aws_s3_bucket_policy" "desecurebucket" {
  bucket = "${aws_s3_bucket.desecurebucket.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::414514217411:user/exp-admin"
      },
      "Action":[
        "s3:GetObject*",
        "s3:PutObject*",
        "s3:DeleteObject*"
      ],
      "Resource": "${aws_s3_bucket.desecurebucket.arn}/*",
      "Condition" : {
        "StringEquals": {
          "aws:sourceVpce": ""
        }
      }
    }
  ]
}
POLICY
}
