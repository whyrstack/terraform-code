/*
# Create KMS for EFS encryption
resource "aws_kms_key" "my_key" {
  description             = "KMS key for EFS"
  deletion_window_in_days = 7
  

  tags = {
    Alias = "my-kms-key"
    Terraform = "true"
    Type = "network"
  }
}

resource "aws_kms_alias" "a" {
  name          = "alias/my-kms-key"
  target_key_id = aws_kms_key.my_key.key_id
}
*/