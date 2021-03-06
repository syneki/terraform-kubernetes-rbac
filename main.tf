resource "kubernetes_service_account" "this" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = var.labels
  }
}


resource "kubernetes_cluster_role" "this" {
  metadata {
    name   = var.name
    labels = var.labels
  }

  dynamic "rule" {
    for_each = var.cluster_role.rules

    content {
      api_groups        = try(rule.value.api_groups, null)
      resources         = try(rule.value.resources, null)
      non_resource_urls = try(rule.value.non_resource_urls, null)
      verbs             = rule.value.verbs
    }
  }
}

resource "kubernetes_cluster_role_binding" "this" {
  metadata {
    name = var.name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.this.metadata[0].name
    namespace = kubernetes_service_account.this.metadata[0].namespace
  }

  role_ref {
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.this.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_role" "this" {
  for_each = {
    for obj in var.roles : "${obj.name}" => obj
  }

  metadata {
    name      = "${var.name}-${each.value.name}"
    namespace = var.namespace
    labels    = var.labels
  }

  dynamic "rule" {
    for_each = each.value.rules

    content {
      api_groups = rule.value.api_groups
      resources  = rule.value.resources
      verbs      = rule.value.verbs
    }
  }
}

resource "kubernetes_role_binding" "this" {

  for_each = kubernetes_role.this

  metadata {
    name      = each.value.metadata[0].name
    namespace = each.value.metadata[0].namespace
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.this.metadata[0].name
    namespace = kubernetes_service_account.this.metadata[0].namespace
  }

  role_ref {
    kind      = "Role"
    name      = each.value.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}
