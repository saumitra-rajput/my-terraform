# basic terraform provider file

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.38.0"
    }
  }

# defining terraform to use the remote-backend

#backend "s3" {
#	bucket = "remote-rockingstatebucket"
#	dynamodb_table = "remote-rockingstatedynamodb"
#	key = "terraform.tfstate"
#	region = "us-west-2"
#	}

}


