output "security_group" {
    value = "${aws_security_group.default.id}"
}

output "web_ip_1" {
    value = "${aws_instance.web_1.public_ip}"
}

output "web_ip_2" {
    value = "${aws_instance.web_2.public_ip}"
}

output "elb_address" {
    value = "${aws_elb.web.dns_name}"
}

