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
}