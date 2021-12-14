variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  default     = ""
}

variable "region" {
 type = string 
 description = "where the bucket will be created"
 default = ""
}