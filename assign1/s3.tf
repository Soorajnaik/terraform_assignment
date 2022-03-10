resource "aws_s3_bucket" "terra-s3" {
  bucket = "terra-s3-bucket1"

  tags = {
    Name = "soo bucket"
    Enviornment = "Terraform"
  }
}
resource "aws_s3_bucket_acl" "terra-s3" {
  bucket = aws_s3_bucket.terra-s3.id
  acl = "private"
}
#resource "aws_s3_bucket_policy" "bucket_policy" {
#  bucket = "${aws_s3_bucket.terra-s3.id}"
  
#  policy = <<EOF
#{
 # "Version": "2012-10-17",
  #"Statement": [
   # {
    #  "Effect": "Allow",
#      "Principal": {
 #       "AWS": "${aws_iam_user.terrasooraj.arn}"
  #    },
  #    "Action": [ "s3:*" ],
   #   "Resource": [
    #    "${aws_s3_bucket.terra-s3.id}",
     #   "${aws_s3_bucket.terra-s3.id}/*"
#      ]
 #   } 
 # ]
#}
#EOF
#}
