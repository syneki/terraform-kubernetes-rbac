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
