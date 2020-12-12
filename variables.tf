variable "do_token" {}

variable "do_region" {
    default = "fra1"
}

variable "do_project_name" {
    default = "Drupal-dev"
}

variable "do_cluster_name" {
    default = "drupal-cluster"
}

variable "do_vpc_ip_range" {
    default = "10.135.10.0/24"
}
