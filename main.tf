terraform {
  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = "0.6.0"
    }
  }
}

provider "minikube" {
  kubernetes_version = "v1.30.2"
}

resource "minikube_cluster" "local" {
  driver       = "docker"
  cluster_name = "task-01-cluster"
  addons = [
    "default-storageclass",
    "storage-provisioner"
  ]
  nodes = 2
  cni   = "calico"
}

provider "kubernetes" {
  host                   = minikube_cluster.local.host
  client_certificate     = minikube_cluster.local.client_certificate
  client_key             = minikube_cluster.local.client_key
  cluster_ca_certificate = minikube_cluster.local.cluster_ca_certificate
}

variable "namespaces_to_create" {
  type    = list(string)
  default = ["webapp", "monitoring"]
}
resource "kubernetes_namespace_v1" "namespaces" {
  for_each = toset(var.namespaces_to_create)

  metadata {
    name = each.value
  }
}
