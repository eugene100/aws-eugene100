data "aws_s3_bucket" "eugene100-terraform-tfstate" {
  bucket = "eugene100-terraform-tfstate"
}

resource "aws_s3_bucket" "k8s-state-store" {
    bucket = "eugene100-k8s-state-store"
    acl    = "private"
}