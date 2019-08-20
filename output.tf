output "Wordpress_Instance_Public_IP" {
  value = ["${aws_instance.wordpress_ec2.public_ip}"]
}
