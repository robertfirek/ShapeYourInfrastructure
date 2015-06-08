resource "aws_vpc" "environment" {
    cidr_block = "${var.vpc.cidr_block}"

    tags {
        Name        = "${var.environment_name}-vpc"
        Environment = "${var.environment_name}"
    }
}

resource "aws_internet_gateway" "environment" {
    vpc_id = "${aws_vpc.environment.id}"

    tags {
        Name        = "${var.environment_name}-internet-gateway"
        Environment = "${var.environment_name}"
    }
}
