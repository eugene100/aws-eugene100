terraform {
  backend "s3" {
    bucket = "eugene100-terraform-tfstate"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  version = "~> 1.57"
  region  = "${var.region}"
}
