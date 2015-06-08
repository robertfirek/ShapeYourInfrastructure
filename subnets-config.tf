resource "aws_subnet" "public-subnet" {
    vpc_id            = "${aws_vpc.environment.id}"
    cidr_block        = "${var.vpc_public_subnet.cidr_block}"
    availability_zone = "${var.vpc_public_subnet.availability_zone}"

    tags {
        Name        = "${var.environment_name}-public-subnet"
        Environment = "${var.environment_name}"
    }
}

resource "aws_subnet" "private-subnet" {
    vpc_id            = "${aws_vpc.environment.id}"
    cidr_block        = "${var.vpc_private_subnet.cidr_block}"
    availability_zone = "${var.vpc_private_subnet.availability_zone}"

    tags {
        Name        = "${var.environment_name}-private-subnet"
        Environment = "${var.environment_name}"
    }
}
