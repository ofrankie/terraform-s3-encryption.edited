# ----------------------------------------------------------------------------------------
#  Secret Manager
# ----------------------------------------------------------------------------------------r
variable "project_name" { default= "name"}
resource "aws_secretsmanager_secret" "DEV-SMK_CA_API_KEY" {
  name = "DEV/SMK_CA_API_KEY"
  description = "DEV SMK_CA_API_KEY Secret"
  
}
resource "aws_secretsmanager_secret_version" "DEV-SMK_CA_API_KEY_SecretVersion" {
  secret_id     = "${aws_secretsmanager_secret.DEV-SMK_CA_API_KEY.id}"
  secret_string = "dev-dummy"
}

resource "aws_secretsmanager_secret" "QA-SMK_CA_API_KEY" {
  name = "QA/SMK_CA_API_KEY"
  description = "QA SMK_CA_API_KEY Secret"
  
}
resource "aws_secretsmanager_secret_version" "QA-SMK_CA_API_KEY_SecretVersion" {
  secret_id     = "${aws_secretsmanager_secret.QA-SMK_CA_API_KEY.id}"
  secret_string = "qa-dummy"
}

resource "aws_secretsmanager_secret" "PROD-SMK_CA_API_KEY" {
  name = "PROD/SMK_CA_API_KEY"
  description = "PROD SMK_CA_API_KEY Secret"
  
}
resource "aws_secretsmanager_secret_version" "PROD-SMK_CA_API_KEY_SecretVersion" {
  secret_id     = "${aws_secretsmanager_secret.PROD-SMK_CA_API_KEY.id}"
  secret_string = "prod-dummy"
}

resource "aws_secretsmanager_secret" "DEV-SMK_FFB_REST_API_KEY" {
  name = "DEV/SMK_FFB_REST_API_KEY"
  description = "DEV SMK_CA_API_KEY Secret"
  
}
resource "aws_secretsmanager_secret_version" "DEV-SMK_FFB_REST_API_KEY_SecretVersion" {
  secret_id     = "${aws_secretsmanager_secret.DEV-SMK_FFB_REST_API_KEY.id}"
  secret_string = "dev-dummy"
}

resource "aws_secretsmanager_secret" "QA-SMK_FFB_REST_API_KEY" {
  name = "QA/SMK_FFB_REST_API_KEY"
  description = "QA SMK_FFB_REST_API_KEY Secret"
  
}
resource "aws_secretsmanager_secret_version" "QA-SMK_FFB_REST_API_KEY_SecretVersion" {
  secret_id     = "${aws_secretsmanager_secret.QA-SMK_FFB_REST_API_KEY.id}"
  secret_string = "qa-dummy"
}

resource "aws_secretsmanager_secret" "PROD-SMK_FFB_REST_API_KEY" {
  name = "PROD/SMK_FFB_REST_API_KEY"
  description = "PROD SMK_FFB_REST_API_KEY Secret"
  
}
resource "aws_secretsmanager_secret_version" "PROD-SMK_FFB_REST_API_KEY_SecretVersion" {
  secret_id     = "${aws_secretsmanager_secret.PROD-SMK_FFB_REST_API_KEY.id}"
  secret_string = "prod-dummy"
}


#====================================================
data "template_file" "devbucketarn" {
  template = "${file("dev.bucketpolicy.json.tpl")}"

  vars {
    devbucket = "${aws_s3_bucket.dev-desecurebucket.arn}/*"
    test_role_arn = "${var.project_name}_test_lambda_role"
    caller_identity = "${data.aws_caller_identity.current.account_id}"
  }
}



resource "aws_s3_bucket_policy" "dev-desecurebucket" {
  bucket = "${aws_s3_bucket.dev-desecurebucket.id}"

  policy = "${data.template_file.devbucketarn.rendered}"

}

#====================================================
data "template_file" "qabucketarn" {
  template = "${file("qa.bucketpolicy.json.tpl")}"

  vars {
    qabucket   = "${aws_s3_bucket.qa-desecurebucket.arn}/*"
    test_role_arn = "${var.project_name}_test_lambda_role"
    caller_identity = "${data.aws_caller_identity.current.account_id}"
  }
}



resource "aws_s3_bucket_policy" "qa-desecurebucket" {
  bucket = "${aws_s3_bucket.qa-desecurebucket.id}"

  policy = "${data.template_file.qabucketarn.rendered}"

}

#====================================================
data "template_file" "prodbucketarn" {
  template = "${file("prod.bucketpolicy.json.tpl")}"

  vars {
    prodbucket = "${aws_s3_bucket.prod-desecurebucket.arn}/*"
    test_role_arn = "${var.project_name}_test_lambda_role"
    caller_identity = "${data.aws_caller_identity.current.account_id}"
  }
}



resource "aws_s3_bucket_policy" "prod-desecurebucket" {
  bucket = "${aws_s3_bucket.prod-desecurebucket.id}"

  policy = "${data.template_file.prodbucketarn.rendered}"

}
#===============================================================

# Bucket Policy - dev-desecurebucket
resource "aws_s3_bucket" "dev-desecurebucket" {
  bucket_prefix = "${var.dev-base_name}"
  acl           = "private"
  region        = "${var.aws_region}"
  tags          = "${merge(map("Name", "${var.dev-base_name}"), var.tags)}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.dev-desecurebucket.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }
}


# Bucket Policy - qa-desecurebucket
resource "aws_s3_bucket" "qa-desecurebucket" {
  bucket_prefix = "${var.qa-base_name}"
  acl           = "private"
  region        = "${var.aws_region}"
  tags          = "${merge(map("Name", "${var.qa-base_name}"), var.tags)}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.qa-desecurebucket.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

#



#
# Bucket Policy - prod-desecurebucket
resource "aws_s3_bucket" "prod-desecurebucket" {
  bucket_prefix = "${var.prod-base_name}"
  acl           = "private"
  region        = "${var.aws_region}"
  tags          = "${merge(map("Name", "${var.prod-base_name}"), var.tags)}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.prod-desecurebucket.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

#
# Bucket Policy

