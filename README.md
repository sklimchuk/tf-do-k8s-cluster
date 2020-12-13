# README

Without any modification this code will create Kubernetes, Redis and MySQL clusters on Digital Ocean cloud hosting (using default settings, cluster's sizing specified in main.tf).

If you need custom settings, just update them in variables.tf and main.tf to your values before first run.

It assumes you have a Digital Ocean token ([how to get one](https://www.digitalocean.com/docs/api/create-personal-access-token/)).

## How to run

```
$ export TF_VAR_do_token=your_digital_ocean_token
$ git clone https://github.com/sklimchuk/tf-do-k8s-cluster.git
$ cd tf-do-k8s-cluster
$ terraform init
$ terraform plan
$ terraform apply

For further using exported 'your_cluster_name-k8s-kubeconfig.yaml' config:
$ export KUBECONFIG="path_to/your_cluster_name-k8s-kubeconfig.yaml"
$ kubectl cluster-info
$ kubectl get nodes
```
