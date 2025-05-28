resource "aws_secretsmanager_secret" "jwt-secret-key" {
 name = "jwt-secret-key"
 recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "jwt-secret-version" {
 secret_id = aws_secretsmanager_secret.jwt-secret-key.id
 secret_string = jsonencode({
   jwt-key = "498d6f0f373eaf3756caa0ee0d6a9b2ad561116cc64c10b8885153b62b07c4a2"
 })
}