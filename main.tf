# https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs

terraform {
  required_providers {
      digitalocean = {
        source = "digitalocean/digitalocean"
        version = "~> 1.22.1"
      }
    }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_vpc" "do_vpc" {
  name     = format("%s-%s", var.do_cluster_name, "vpc")
  region   = var.do_region
  ip_range = var.do_vpc_ip_range
}

resource "digitalocean_kubernetes_cluster" "do_k8s_cluster" {
  name          = format("%s-%s", var.do_cluster_name, "k8s")
  region        = var.do_region
  version       = "1.19.3-do.2"
  auto_upgrade  = true
  vpc_uuid      = digitalocean_vpc.do_vpc.id
  tags          = [var.do_project_name, "k8s-terraform"]

  node_pool {
    name       = "worker-pool"
    size       = "s-1vcpu-2gb"
    auto_scale = true
    min_nodes  = 3
    max_nodes  = 5
  }
}

resource "digitalocean_database_cluster" "do_redis_cluster" {
  name                  = format("%s-%s", var.do_cluster_name, "redis")
  engine                = "redis"
  version               = "6"
  size                  = "db-s-1vcpu-1gb"
  region                = var.do_region
  eviction_policy       = "allkeys_lru"
  node_count            = 1
  private_network_uuid  = digitalocean_vpc.do_vpc.id
  tags                  = [var.do_project_name, "redis-terraform"]
}

resource "digitalocean_database_cluster" "do_mysql_cluster" {
  name                  = format("%s-%s", var.do_cluster_name, "mysql")
  engine                = "mysql"
  version               = "8"
  size                  = "db-s-1vcpu-1gb"
  region                = var.do_region
  node_count            = 1
  private_network_uuid  = digitalocean_vpc.do_vpc.id
  tags                  = [var.do_project_name, "mysql-terraform"]
}


data "digitalocean_project" "do_project" {
  name = var.do_project_name
}

# k8s cluster can't be placed under proj. res. group - https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project_resources
resource "digitalocean_project_resources" "do_project_resources" {
  project = data.digitalocean_project.do_project.id
  resources = [
    digitalocean_database_cluster.do_redis_cluster.urn,
    digitalocean_database_cluster.do_mysql_cluster.urn
  ]
}

resource "local_file" "k8s_config" {
    content         = digitalocean_kubernetes_cluster.do_k8s_cluster.kube_config.0.raw_config
    filename        = format("%s-%s", var.do_cluster_name, "k8s-kubeconfig.yaml")
    file_permission = "0400"
}
