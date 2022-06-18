<!-- BEGIN_TF_DOCS -->
# Terraform Kubernetes RBAC Module

Terraform module which create Kubernetes Service Account with RBAC Authorization.

## Usage

```hcl
module "rbac_example" {
  source = "../"

  name = "rbac-example"

  cluster_role = {
    rules = [
      {
        api_groups = [""]
        resources  = ["nodes", "namespaces", "events", "pods", "services", "configmaps", "serviceaccounts", "peristentvolumes", "persistentvolumeclaims"]
        verbs      = ["get", "list", "watch"]
      },
      {
        api_groups = ["extensions"]
        resources  = ["replicasets"]
        verbs      = ["get", "list", "watch"]

      },
      {
        api_groups = ["apps"]
        resources  = ["statefulsets", "deployments", "replicasets", "daemonsets"]
      verbs = ["get", "list", "watch"] },
      {
        api_groups = [""]
        resources  = ["nodes/stats"]
        verbs      = ["get"]
      },
      {
        api_groups = ["batch"]
        resources  = ["jobs", "cronjobs"]
        verbs      = ["get", "list", "watch"]
      },
      {
        non_resource_urls = ["/metrics"]
        verbs             = ["get"]
      },
      {
        api_groups = ["rbac.authorization.k8s.io"]
        resources  = ["clusterrolebindings", "clusterroles", "rolebindings", "roles"]
        verbs      = ["get", "list", "watch"]
      },
      {
        api_groups = ["policy"]
        resources  = ["podsecuritypolicies"]
        verbs      = ["get", "list", "watch"]
      }
    ]
  }

  roles = [
    {
      name = "kubeadm-config" # The name will be rbac-example-kubeadm-config
      rules = [
        {
          api_groups     = [""]
          resources      = ["configmaps"]
          resource_names = ["kubeadm-config"]
          verbs          = ["get"]
        },
      ]
    },
    {
      name = "kubeadm-config" # The name will be rbac-example-kubeadm-config
      rules = [
        {
          api_groups = ["coordination.k8s.io"]
          resources  = ["leases"]
          verbs      = ["get", "create", "update"]
        },
      ]
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.11.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_cluster_role.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_role.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role) | resource |
| [kubernetes_role_binding.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_service_account.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_role"></a> [cluster\_role](#input\_cluster\_role) | Configuration for the Cluster Role | <pre>object({<br>    rules = set(map(list(string)))<br>  })</pre> | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels append to created resources | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name used to create resources | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace where resources will be created | `string` | `"default"` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | Configuration for the Roles | <pre>list(object({<br>    name  = string<br>    rules = set(map(list(string)))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_roles"></a> [roles](#output\_roles) | The created Roles name |
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | The created ServiceAccount name |
<!-- END_TF_DOCS -->
