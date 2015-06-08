resource "aws_security_group" "nat" {
    name = "${var.environment_name}-nat"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 123
        to_port     = 123
        protocol    = "udp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["${var.vpc_private_subnet.cidr_block}"]
    }
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["${var.vpc_private_subnet.cidr_block}"]
    }

    egress {
        from_port   = 123
        to_port     = 123
        protocol    = "udp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.environment.id}"
    tags {
        Name        = "${var.environment_name}-nat-security-group"
        Environment = "${var.environment_name}"
    }
}

resource "aws_security_group" "public" {
    name = "${var.environment_name}-public"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.environment.id}"
    tags {
        Name        = "${var.environment_name}-public-security-group"
        Environment = "${var.environment_name}"
    }
}

resource "aws_security_group" "private" {
    name = "${var.environment_name}-private"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${var.vpc_public_subnet.cidr_block}"]
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["${var.vpc_public_subnet.cidr_block}"]
    }
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["${var.vpc_public_subnet.cidr_block}"]
    }
    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["${var.vpc_public_subnet.cidr_block}", "${var.vpc_private_subnet.cidr_block}"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.environment.id}"
    tags {
        Name        = "${var.environment_name}-private-security-group"
        Environment = "${var.environment_name}"
    }
}
