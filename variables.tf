variable "aws_region" {}

variable "aws_key_name" {}
variable "aws_key_path" {}

variable "aws_instance_type" {}
variable "aws_instance_user" {}

variable "aws_amis" {
    default = {
        us-east-1 = "ami-246ed34c" # north virginia
    }
}

variable "aws_availability_zones" {
    default = {
        "0" = "us-east-1a"
        "1" = "us-east-1b"
        "2" = "us-east-1c"
    }
}

variable "aws_security_group" {
    default = {
        sg_count                = ""

        sg_0_name               = ""
        sg_0_ingress_from_port  = ""
        sg_0_ingress_to_port    = ""
        sg_0_protocol           = ""

        sg_1_name               = ""
        sg_1_ingress_from_port  = ""
        sg_1_ingress_to_port    = ""
        sg_1_protocol           = ""

        sg_2_name               = ""
        sg_2_ingress_from_port  = ""
        sg_2_ingress_to_port    = ""
        sg_2_protocol           = ""
    }
}

