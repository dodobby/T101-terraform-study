# S3 생성

### S3 VAR

variable "s3_bucket_name" {
  type = string
  description = "AWS S3 Bucket Name"
  default = "hjdo-s3-bucket"
}

### S3 RESOURCE

# S3 버킷
resource "aws_s3_bucket" "example" {
  bucket = var.s3_bucket_name
}

# 버킷 버전 관리
# Amazon S3 > 버킷 > 속성
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 퍼블릭 액세스 차단(버킷 설정)
# Amazon S3 > 버킷 > 권한
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# 버킷 정책
# Amazon S3 > 버킷 > 권한
resource "aws_s3_bucket_policy" "allow_access" {
  bucket = aws_s3_bucket.example.id
  policy =<<EOT
    {
        "Version": "2012-10-17",
        "Id": "Policy1693420742086",
        "Statement": [
            {
                "Sid": "Stmt1693420740660",
                "Effect": "Allow",
                "Principal": "*",
                "Action": [
                    "s3:GetObject",
                    "s3:PutObject"
                ],
                "Resource": "${aws_s3_bucket.example.arn}/*"
            }
        ]
    }
  EOT
}

# S3 버킷 폴더 + 오브젝트
# Amazon S3 > 버킷 > 버킷명
resource "aws_s3_object" "object" {
  bucket = var.s3_bucket_name
  key    = "terraform/ch2/"
  depends_on = [ 
    aws_s3_bucket.example
  ]
}


## -----------------------------------------------------------------------------------------------------------------
# DynamoDB 생성

### Dynamo VAR

variable "dynamo_table_name" {
  type = string
  description = "AWS DynamoDB Table Name"
  default = "hjdo-dynamodb-table"
}

### Dynamo RESOURCE

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = var.dynamo_table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}