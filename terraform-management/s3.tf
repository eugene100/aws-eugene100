resource "aws_s3_bucket" "eugene100-terraform-tfstate" {
    bucket = "eugene100-terraform-tfstate"
    acl    = "private"
}