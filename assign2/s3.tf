terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket = "soorajassign2"
    key = "myapp/state.tfstate"
    region = "ap-southeast-1"
  }
}
data "aws_iam_policy_document" "read_soorajassign2_bucket" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.soorajassign2.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.soorajassign2.arn]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}


resource "aws_s3_bucket" "soorajassign2" {
  bucket = "soorajassign2"
  tags = {
    Name = "sooraj-bucket"
  }
}

resource "aws_s3_bucket_policy" "read_soorajassign2" {
  bucket = aws_s3_bucket.soorajassign2.id
  policy = data.aws_iam_policy_document.read_soorajassign2_bucket.json
}

resource "aws_s3_bucket_public_access_block" "soorajassign2" {
  bucket = aws_s3_bucket.soorajassign2.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "new" {
  bucket = "${aws_s3_bucket.soorajassign2.id}"
  acl = "public-read-write"
}
resource "aws_s3_bucket_object" "object" {
  bucket = "soorajassign2"
  key = "pic1.png"
  acl = "public-read"
  source = "/home/ubuntu/terraform/terrafromassign1/code/terraform_code/Task 1/pic1.png"
  etag = filemd5("/home/ubuntu/terraform/terrafromassign1/code/terraform_code/Task 1/pic1.png")
} 
resource "aws_s3_bucket_object" "object1" {
  bucket = "soorajassign2"
  key = "pic2.png"
  acl = "public-read"
  source = "/home/ubuntu/terraform/terrafromassign1/pic2.png"
  etag = filemd5("/home/ubuntu/terraform/terrafromassign1/pic2.png")
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "origin_access_identity"
}


locals {
  s3_origin_id = "myS3Origin"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.soorajassign2.bucket}.s3.amazonaws.com"
    origin_id   = "${local.s3_origin_id}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
    }
  }
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/content/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
     # locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
