# DEFEKT IAC-06 | CWE-732 | oczekiwana faza 5
resource "aws_iam_policy" "potok" {
  name = "juice-shop-potok-badanie"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      # celowo: nadmierny zakres uprawnien
      Action   = "*"
      Resource = "*"
    }]
  })
}
