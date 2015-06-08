provider "aws" {
    access_key = "${var.provider.access_key}"
    secret_key = "${var.provider.secret_key}"
    region     = "${var.provider.region}"
}
