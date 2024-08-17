# Create an S3 bucket to store the application source code
resource "aws_s3_bucket" "app_bucket" {
  bucket = var.bucket_name
  
}

data "archive_file" "Dockerfile_zip" {
  type        = "zip"
  source_dir = "src"
  output_path = "Dockerfile.zip"
}

# Upload the application source code to the S3 bucket
resource "aws_s3_object" "app_code" {
  bucket = aws_s3_bucket.app_bucket.id
  key    = "app_code/Dockerfile.zip"
  source = data.archive_file.Dockerfile_zip.output_path # Replace with the path to your zipped application source code
}

