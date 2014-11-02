provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

resource "aws_security_group" "default" {
    name = "terraform_security_group"
    description = "AWS security group for terraform example"

    # ssh for everyone
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    # http for everyone
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags {
        Name = "Terraform AWS security group"
    }
}

resource "aws_elb" "web" {
    name = "terraform"

    listener {
        instance_port       = 80
        instance_protocol   = "http"
        lb_port             = 80
        lb_protocol         = "http"
    }

    availability_zones = [
        "${aws_instance.web_1.availability_zone}",
        "${aws_instance.web_2.availability_zone}"
    ]

    instances = [
        "${aws_instance.web_1.id}",
        "${aws_instance.web_2.id}"
    ]
}

resource "aws_instance" "web_1" {
    instance_type = "${var.aws_instance_type}"
    ami = "${lookup(var.aws_amis, var.aws_region)}"

    key_name = "${var.aws_key_name}"
    security_groups = [ "${aws_security_group.default.name}" ]
    associate_public_ip_address = true

    connection {
        user = "${var.aws_instance_user}"
        key_file = "${var.aws_key_path}"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo yum install -y docker",
            "sudo service docker start",
            "sudo docker pull nginx",
            "sudo docker run -d -p 80:80 nginx"
        ]
    }

    tags {
        Name = "Terraform web 1"
    }
}

resource "aws_instance" "web_2" {
    instance_type = "${var.aws_instance_type}"
    ami = "${lookup(var.aws_amis, var.aws_region)}"

    key_name = "${var.aws_key_name}"
    security_groups = [ "${aws_security_group.default.name}" ]
    associate_public_ip_address = true

    connection {
        user = "${var.aws_instance_user}"
        key_file = "${var.aws_key_path}"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo yum install -y docker",
            "sudo service docker start",
            "sudo docker pull nginx",
            "sudo docker run -d -p 80:80 nginx"
        ]
    }

    tags {
        Name = "Terraform web 2"
    }
}

