resource "tls_private_key" "assignment1" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "terassignment1"
  public_key = tls_private_key.assignment1.public_key_openssh
}


resource "aws_instance" "sooraj-public-1" {
    key_name = "Private-key1"
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"
    availability_zone = "ap-southeast-1a"
    vpc_security_group_ids = ["${aws_security_group.allow_http.id}"]
    associate_public_ip_address = true
    user_data = <<-EOL
    #!/bin/bash -xe
    
    apt update
    apt install apache2 -y
    mkfs -t ext4 /dev/xvdf
    mount /dev/xvdf /var/www/html
    git -C /var/www/html clone https://github.com/Soorajnaik/terraform_code.git 
    EOL
    tags = {
        Name = "sooraj-assignment"
    }
}




resource "null_resource" "nullmix" {
 depends_on = [
      aws_cloudfront_distribution.s3_distribution
 ]
 connection {
      type     = "ssh"
      user     = "ubuntu"
      #private_key = "terraformNew"
      private_key = file("/home/ubuntu/terraform/terrafromassign1/Private-key1")
      host     = aws_instance.sooraj-public-1.public_ip
 }
 #provisioner "remote-exec" {
  #    inline = [
   #      "sudo su << EOF",
    #     "echo \"<img src='https://${aws_cloudfront_distribution.s3_distribution.domain_name}/pic1.png'>\" >> /var/www/html/terraform_code/Task 1/index.php",
     #  "EOF"
#  ]
 #}
 #provisioner "local-exec" {
  #    command = "chrome ${aws_instance.sooraj-public-1.public_ip}"
 #}
}
