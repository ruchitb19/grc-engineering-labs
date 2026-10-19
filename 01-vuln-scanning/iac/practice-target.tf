# PRACTICE TARGET ONLY. Never run terraform apply on this file.
# It is deliberately misconfigured so Trivy has something to find.
# The real AWS Terraform comes later, in 03-iam-least-privilege and 04-detection-aws.

resource "aws_security_group" "practice_ssh" {
  name        = "practice-open-ssh"
  description = "Deliberately bad: SSH open to the whole internet"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "practice_bucket" {
  bucket = "practice-target-never-applied"
}
