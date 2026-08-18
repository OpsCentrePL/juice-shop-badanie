# DEFEKT IAC-04 | CWE-284 | oczekiwana faza 5
resource "aws_security_group" "juice_shop" {
  name        = "juice-shop-badanie"
  description = "Grupa zabezpieczen aplikacji testowej"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    # celowo: zasob udostepniony publicznie
    cidr_blocks = ["0.0.0.0/0"]
  }
}
