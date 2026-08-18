# DEFEKT IAC-05 | CWE-311 | oczekiwana faza 5
resource "aws_s3_bucket" "artefakty" {
  bucket = "juice-shop-artefakty-badanie"
}
# celowo: brak aws_s3_bucket_server_side_encryption_configuration
