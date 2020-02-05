provider "kubernetes" {}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "terraform-namespace"
  }
}

resource "kubernetes_pod" "nginx" {
  metadata {
    name = "nginx"
    labels = {
      App = "nginx"
    }
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }

  spec {
    container {
      image = "nginx:1.15.2"
      name  = "nginx"

      port {
        container_port = 80
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name      = "nginx"
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }
  spec {
    selector = {
      App = kubernetes_pod.nginx.metadata.0.labels.App
    }
    port {
      port        = 80 #the external port to use
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
