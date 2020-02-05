resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_pod" "elkstack" {
  metadata {
    name = var.pod_name
    labels = {
      App = "elkstack"
    }
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }

  spec {
    container {
      image = "docker.elastic.co/elasticsearch/elasticsearch:7.5.1"
      name  = "elasticsearch"

      port {
        container_port = 9200
      }
      port {
        container_port = 9300
      }

      env {
        name  = "ES_JAVA_OPTS"
        value = "-Xmx256m -Xms256m"
      }
      env {
        name  = "ELASTIC_PASSWORD"
        value = "changeme"
      }
      env {
        name  = "discovery.type"
        value = "single-node"
      }
      env {
        name  = "cluster.name"
        value = "docker-cluster"
      }
      env {
        name  = "network.host"
        value = "0.0.0.0"
      }
    }

    container {
      image = "docker.elastic.co/logstash/logstash:7.5.1"
      name  = "logstash"

      port {
        container_port = 5000
      }
      port {
        container_port = 9600
      }

      env {
        name  = "ES_JAVA_OPTS"
        value = "-Xmx256m -Xms256m"
      }
      env {
        name  = "http.host"
        value = "0.0.0.0"
      }
      env {
        name  = "ELASTICSEARCH_HOST"
        value = "elasticsearch.elk-stack"
      }
      env {
        name  = "ELASTICSEARCH_PORT"
        value = "9200"
      }
    }

    container {
      image = "docker.elastic.co/kibana/kibana:7.5.1"
      name  = "kibana"

      port {
        container_port = 5601
      }

      env {
        name  = "server.name"
        value = "kibana"
      }
      env {
        name  = "server.host"
        value = "0"
      }
      env {
        name  = "ELASTICSEARCH_HOST"
        value = "elasticsearch.elk-stack"
      }
      env {
        name  = "ELASTICSEARCH_PORT"
        value = "9200"
      }
      env {
        name  = "elasticsearch.username"
        value = "elastic"
      }
      env {
        name  = "elasticsearch.password"
        value = "changeme"
      }
    }
  }
}

resource "kubernetes_service" "elasticsearch" {
  metadata {
    name      = "elasticsearch"
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }
  spec {
    selector = {
      App = kubernetes_pod.elkstack.metadata.0.labels.App
    }
    port {
      port        = 9200
      target_port = 9200
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_service" "kibana" {
  metadata {
    name      = "kibana"
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }
  spec {
    selector = {
      App = kubernetes_pod.elkstack.metadata.0.labels.App
    }
    port {
      port        = 8080
      target_port = 5601
    }

    type = "LoadBalancer"
  }
}
