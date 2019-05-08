{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject*",
        "s3:PutObject*",
        "s3:DeleteObject*"
      ],
      "Effect": "Allow",
      "Resource": [ 
        "${qabucket}"
      ],
      "Principal": {
        "AWS": [
          "arn:aws:iam::${caller_identity}:role/${test_role_arn}"
        ]
      }
    }
  ]
}
