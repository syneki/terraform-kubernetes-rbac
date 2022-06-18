output "service_account" {
  value       = kubernetes_service_account.this.metadata[0].name
  description = "The created ServiceAccount name"
}

output "roles" {
  value       = kubernetes_role.this
  description = "The created Roles name"
}
