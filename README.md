# terraform-examples
Terraform playground

## Prerequisite Setup for Kubernetes

1. Install kubernetes in local docker
2. Install `kubectl` with brew or via instructions on https://kubernetes.io/docs/tasks/tools/install-kubectl/

### Optional: Dashboard

1. Install dashboard via `kubectl` with instructions found at https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
2. Create a kubeconfig with `script/createkubeconfig > kubeconfig`
3. Run dashboard with `kubectl proxy`
4. Open dashboard at http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
5. Use the kubeconfig to sign in