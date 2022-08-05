data "aws_s3_bucket" "eugene100-terraform-tfstate" {
  bucket = "eugene100-terraform-tfstate"
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "eugene100-k8s-state-store"
  acl    = "private"

  versioning = {
    enabled = true
  }

}
