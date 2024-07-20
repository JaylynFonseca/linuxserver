# 9) Creat IAM Role to acces S3
resource "aws_iam_role" "linuxuser" {
  name = "linuxuser"

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

  tags = {
      Name = "linuxuser"
  }
}

// IAM Profile
resource "aws_iam_instance_profile" "linuxuser_Profile" {
  name = "linuxuser-profile"
  role = "${aws_iam_role.linuxuser.name}"
}

// IAM Policy
resource "aws_iam_role_policy" "EC2-S3_Policy" {
  name = "EC2-S3-Policy"
  role = "${aws_iam_role.linuxuser.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
 
}