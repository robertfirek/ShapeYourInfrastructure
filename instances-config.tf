resource "aws_instance" "nat" {
    ami                         = "${var.nat.ami_image}"
    availability_zone           = "${var.nat.availability_zone}"
    instance_type               = "t2.micro"
    key_name                    = "${var.nat.key_name}"
    security_groups             = ["${aws_security_group.nat.id}"]
    subnet_id                   = "${aws_subnet.public-subnet.id}"
    associate_public_ip_address = true
    source_dest_check           = false

    tags {
        Name        = "${var.environment_name}-nat"
        Environment = "${var.environment_name}"
    }
}

resource "aws_eip" "nat" {
    instance = "${aws_instance.nat.id}"
    vpc      = true
}

resource "aws_instance" "web-proxy" {
    ami                         = "${var.web-proxy.ami_image}"
    availability_zone           = "${var.web-proxy.availability_zone}"
    instance_type               = "t2.micro"
    key_name                    = "${var.web-proxy.key_name}"
    security_groups             = ["${aws_security_group.public.id}"]
    subnet_id                   = "${aws_subnet.public-subnet.id}"
    associate_public_ip_address = true
    source_dest_check           = true

    tags {
        Name        = "${var.environment_name}-web-proxy"
        Environment = "${var.environment_name}"
    }
}

resource "aws_eip" "web-proxy" {
  instance = "${aws_instance.web-proxy.id}"
  vpc      = true
}

resource "aws_instance" "database" {
    ami                         = "${var.database.ami_image}"
    availability_zone           = "${var.database.availability_zone}"
    instance_type               = "t2.micro"
    key_name                    = "${var.database.key_name}"
    security_groups             = ["${aws_security_group.private.id}"]
    subnet_id                   = "${aws_subnet.private-subnet.id}"
    associate_public_ip_address = false
    source_dest_check           = true

    tags {
        Name        = "${var.environment_name}-database"
        Environment = "${var.environment_name}"
    }
}

resource "aws_instance" "service" {
    ami                         = "${var.services.ami_image}"
    availability_zone           = "${var.services.availability_zone}"
    instance_type               = "t2.micro"
    key_name                    = "${var.services.key_name}"
    security_groups             = ["${aws_security_group.private.id}"]
    subnet_id                   = "${aws_subnet.private-subnet.id}"
    associate_public_ip_address = false
    source_dest_check           = true
    count                       = 3

    tags {
        Name        = "${var.environment_name}-service-${count.index}"
        Environment = "${var.environment_name}"
    }
}
