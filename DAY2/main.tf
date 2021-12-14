# EC2 role to access s3 service
resource "aws_iam_role" "ec2_s3_role" {
    name = "ec2_s3_rw_role"
    assume_role_policy = jsonencode(
    {
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
    

}

resource "aws_iam_role_policy" "ec2_s3_role_policy" {
    name = "ec2_s3_role_policy"
    role = aws_iam_role.ec2_s3_role.id
    policy = jsonencode(
            {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Sid": "s3getandputObject",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Effect": "Allow",
            "Resource": "*"
            }
        
        ]
        })
  
  
}

resource "aws_iam_instance_profile" "instace_profile" {
    name = "ec2_s3_instance_profile"
    role = aws_iam_role.ec2_s3_role.name
  
}

resource "aws_instance" "testIntance" {
    ami = "ami-04ad2567c9e3d7893"
    instance_type = "t2.micro"
    key_name = "mynovakp"
    iam_instance_profile = aws_iam_instance_profile.instace_profile.name
    associate_public_ip_address = true
  
  
}