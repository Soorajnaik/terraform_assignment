resource "aws_ebs_volume" "sooraj_volume" {
  availability_zone = "ap-southeast-1a"
  size = 8
  encrypted = false
  tags = {
    name = "sooraj_volume"
  }
}

resource "aws_volume_attachment" "soor-vol" {
  device_name = "/dev/xvdf"
  volume_id = "${aws_ebs_volume.sooraj_volume.id}"
  instance_id = "${aws_instance.sooraj-public-1.id}"
  stop_instance_before_detaching = true
}

#resource "template_file" "userdata" {
#  template = "userdata.sh"
#}
