terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

terraform {
  cloud {
    organization = "TFBC_KK"

    workspaces {
      name = "terra-house-1"
    }
  }
}

provider "random" {
  # Configuration options
}

resource "aws_s3_bucket" "example" {
  #Bucket naming rules
  #https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
  bucket = random_string.bucket_name.id

}

resource "random_string" "bucket_name" {
  #random TF provider
  #https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
  length           = 27
  special          = false
  lower            = true
  upper            = false
}

output "random_bucket_name"{
    value = random_string.bucket_name.id
}