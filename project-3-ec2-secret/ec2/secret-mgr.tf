# The map here can come from other supported configurations
# like locals, resource attribute, map() built-in, etc.
variable "test" {
  default = {
    key1 = "password1"
    key2 = "password2"
  }

  type = map(string)
}

# Creating a AWS secret for database master account (Masteraccoundb)
 
resource "aws_secretsmanager_secret" "secret_account" {
   name = "my-secret2-account"
}

resource "aws_secretsmanager_secret_version" "test" {
  secret_id     = aws_secretsmanager_secret.secret_account.id
  secret_string = jsonencode(var.test)
}