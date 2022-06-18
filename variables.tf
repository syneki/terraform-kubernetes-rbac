variable "name" {
  type        = string
  description = "Name used to create resources"
}

variable "namespace" {
  type        = string
  default     = "default"
  description = "Namespace where resources will be created"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels append to created resources"
}

variable "cluster_role" {
  type = object({
    rules = set(map(list(string)))
  })

  description = "Configuration for the Cluster Role"
}

variable "roles" {
  type = list(object({
    name  = string
    rules = set(map(string))
  }))

  description = "Configuration for the Roles"
}
