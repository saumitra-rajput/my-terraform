


# s3 

resource "aws_s3_bucket" "statebucks" {
	bucket = "remote-rockingstatebucket"
	tags = {
	Name = "rockingstatebuckettag"	
 	}
}

# dynamoDB table

resource "aws_dynamodb_table" "mydynamodb" {
	name 	= "remote-rockingstatedynamodb"
	billing_mode = "PAY_PER_REQUEST"
	hash_key = "LockID"

	attribute {
	  name = "LockID"
	  type = "S"
	}

}


