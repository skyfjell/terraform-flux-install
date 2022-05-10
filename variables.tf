variable "name" {
  description = "Name of the cluster"
  default     = "default"
  type        = string
}

variable "namespace" {
  description = "Namespace to install in, and create(if enabled)"
  default     = "flux-system"
  type        = string
}

variable "create_namespace" {
  description = "Create Namespace?"
  default     = true
  type        = bool
}

variable "cluster_domain" {
  description = "Cluster Domain"
  default     = "cluster.local"
  type        = string
}

variable "tolerations" {
  description = "Toleration keys for the flux components"
  default     = []
  type        = list(string)
}

variable "network_policy" {
  description = "Install flux with network policy"
  default     = true
  type        = bool
}

variable "flux_version" {
  description = "Flux version"
  default     = "v0.30.2"
  type        = string
}

variable "install_crds" {
  description = "Install CRDs?"
  default     = true
  type        = bool
}

variable "install_controllers" {
  description = "Install Controllers?"
  default     = true
  type        = bool
}

variable "resources" {
  description = "Deployment Pod Resources"
  default     = {}
  type = map(object({
    limits = optional(object({
      cpu    = optional(string)
      memory = optional(string)
    })),
    requests = optional(object({
      cpu    = optional(string)
      memory = optional(string)
    })),
  }))
}
