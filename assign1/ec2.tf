resource "aws_key_pair" "terraformtest" {
  key_name = "terraformNew1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCK38c8/eKxdIwQYPa/xzuCKwG04AHk+O1CVxQkJnjzp8dBMv3QUv/fGkjp4pH45VYyud61TCEaP83oRYjfD86nIqzSPJK4DxH55dldXeXsLrzhO9ri264XMTY1y3JDGGHKFtTnBZo37bONdK9T7m4ByUOuZEO48JEs7YdZlAKF9UtbdFEsLrbeeQ76MKoftJkeJrZPTEndB5+A9G5gLnWtXPzr5oDALiBis796Q/jjlpapFqnM5jPL1BAH9nZ0ZU8ULn7TyHO3Hf+MlaJU6tYFvJIcJXX0eHHk/KrMxtaMEGb39CkxlcG6TYy5zEr79CjY3JPbBUcuiBvfyOuGOxnF terraformNew1"
}
resource "aws_instance" "sooraj-public-1" {
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"
    # VPC
    subnet_id = "${aws_subnet.public-subnet-1.id}"
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.sooraj.id}"]
    key_name = "terraformNew"
    # EC2 IAM Instance Profile
    iam_instance_profile = "${aws_iam_instance_profile.sooraj_profile.id}"
    tags = {
        Name = "sooraj-public-1"
    }
}
resource "aws_instance" "sooraj-private-1" {
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.private-subnet-1.id}"
    vpc_security_group_ids = ["${aws_security_group.sooraj.id}"]
    tags = {
        Name = "sooraj-private-1"
    } 
}


output "instance_machinamespace" {
  value = aws_instance.sooraj-public-1.public_ip
}
