terraform {
  backend "s3" {
    bucket = "eugene100-terraform-tfstate"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  version = "~> 2.7"
  region  = "${var.region}"
}
