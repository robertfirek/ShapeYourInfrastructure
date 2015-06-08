resource "aws_route_table" "public-subnet" {
    vpc_id = "${aws_vpc.environment.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.environment.id}"
    }

    tags {
        Name        = "${var.environment_name}-public-subnet-route-table"
        Environment = "${var.environment_name}"
    }
}

resource "aws_route_table_association" "public-subnet" {
    subnet_id      = "${aws_subnet.public-subnet.id}"
    route_table_id = "${aws_route_table.public-subnet.id}"
}

resource "aws_route_table" "private-subnet" {
    vpc_id = "${aws_vpc.environment.id}"

    route {
        cidr_block  = "0.0.0.0/0"
        instance_id = "${aws_instance.nat.id}"
    }

    tags {
        Name        = "${var.environment_name}-private-subnet-route-table"
        Environment = "${var.environment_name}"
    }
}

resource "aws_route_table_association" "private-subnet" {
    subnet_id      = "${aws_subnet.private-subnet.id}"
    route_table_id = "${aws_route_table.private-subnet.id}"
}
