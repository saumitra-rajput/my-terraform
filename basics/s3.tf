# this file will create a S2 bucket



# in args jarvis_buck not vaild only hypen and numchars allowed.

resource "aws_s3_bucket" "jbucks" {

  bucket = "jarvis-bucks"

}
