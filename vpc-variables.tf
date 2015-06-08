variable "vpc" {
    default = {
        owner_id = "unknown"
        cidr_block = "10.changeit.0.0/16"
    }
}
variable "vpc_public_subnet" {
    default = {
        cidr_block = "10.changeit.0.0/24"
        availability_zone = "changeit"
    }
}
variable "vpc_private_subnet" {
    default = {
        cidr_block = "10.changeit.1.0/24"
        availability_zone = "changeit"
    }
}
