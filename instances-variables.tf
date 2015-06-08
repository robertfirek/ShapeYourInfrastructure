variable "nat" {
    default = {
        ami_image         = "ami-14913f63"
        availability_zone = "unknown"
        key_name          = "unknown"
    }
}

variable "web-proxy" {
    default = {
        ami_image         = "ami-2c90315b"
        availability_zone = "unknown"
        key_name          = "unknown"
    }
}

variable "database" {
    default = {
        ami_image         = "ami-2c90315b"
        availability_zone = "unknown"
        key_name          = "unknown"
    }
}

variable "services" {
    default = {
        ami_image         = "ami-2c90315b"
        availability_zone = "unknown"
        key_name          = "unknown"
    }
}
