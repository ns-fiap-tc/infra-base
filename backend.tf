terraform {
  backend "s3" {
    bucket         = "lanchonete-tfstate-bucket"
    key            = "infra-base/terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
