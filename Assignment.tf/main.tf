# The S3 bucket 
resource "aws_s3_bucket" "dev_team_bucket" {
  bucket = var.s3_bucket_name
  acl    = "private"
  server_side_encryption_configuration {
    rule {
              apply_server_side_encryption_by_default {
                kms_master_key_id = aws_kms_key.mykey.arn
                sse_algorithm = "aws:kms"
              }
      
    }
  }
}
resource "aws_iam_role" "ec2_s3_role" {
  name = "ec2_s3_r_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}
resource "aws_iam_role_policy" "ec2_s3_role" {
  name = "ec2_s3_role_policy"
  role = aws_iam_role.ec2_s3_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

  
  resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  enable_key_rotation = true
  policy = data.aws_iam_policy_document.key_policy.json
  }