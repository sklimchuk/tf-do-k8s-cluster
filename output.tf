output "vpc-id" {
  value = digitalocean_vpc.do_vpc.id
}

output "k8s-cluster-id" {
  value = digitalocean_kubernetes_cluster.do_k8s_cluster.id
}

output "redis-cluster-private-uri" {
  value = digitalocean_database_cluster.do_redis_cluster.private_uri
}

output "mysql-cluster-private-uri" {
  value = digitalocean_database_cluster.do_mysql_cluster.private_uri
}
