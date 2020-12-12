# README

Terraform config to create a Kubernetes cluster on Digital Ocean.

It assumes you have a Digital Ocean token ([how to get one](https://www.digitalocean.com/docs/api/create-personal-access-token/)).

## How to run

```
$ git clone https://github.com/sklimchuk/tf-do-k8s-cluster.git
$ export TF_VAR_do_token=your_digital_ocean_token
$ cd tf-do-k8s-cluster
$ terraform plan
$ terraform apply

For further using exported 'your_cluster_name-k8s-kubeconfig.yaml' config:
$ export KUBECONFIG="path_to_your/your_cluster_name-k8s-kubeconfig.yaml"
$ kubectl cluster-info
$ kubectl get nodes
```

## NB

Without any modification this code will create k8s, redis and mysql clusters (sizing specified in main.tf).
If you need custom settings, just update variables in variables.tf and main.tf to your values before first run.
