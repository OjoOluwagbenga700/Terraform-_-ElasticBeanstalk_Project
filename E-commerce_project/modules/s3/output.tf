output "bucket_id" {
  value = aws_s3_bucket.app_bucket.id
}


  
output "object_app_code_content" {
  value = aws_s3_object.app_code.content
}

output "object_app_code_id" {
  value = aws_s3_object.app_code.id
}
  