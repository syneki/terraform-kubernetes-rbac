variable "name" {
  type = string
}

variable "namespace" {
  type    = string
  default = "default"
}

variable "labels" {
  type = map(string)
  default = {}
}

variable "cluster_role" {
  type = object({
    rules = set(map(list(string)))
  })
}

variable "roles" {
  type = list(object({
    name   = string
    rules = set(map(string))
  }))
}
