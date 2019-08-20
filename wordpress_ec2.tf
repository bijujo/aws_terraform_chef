data "template_file" "user_data_file" {
  template = "${file("scripts/bootstrap.sh")}"
}

resource "aws_instance" "wordpress_ec2" {
  ami                    = "${var.instance_ami}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${aws_subnet.subnet_public.id}"
  vpc_security_group_ids = ["${aws_security_group.cm_sg.id}"]
  key_name               = "${var.key}"
  user_data              = "${data.template_file.user_data_file.rendered}"

  tags = {
    Name = "${var.app_name}"
  }
}
