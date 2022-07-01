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
  type        = list(map(string))
}

variable "node_selector" {
  description = "Node Selector for Components"
  default     = {}
  type        = map(string)
}

variable "node_selectors" {
  description = "Node Selectors for the flux components"
  type = object(
    {
      spec = optional(string)
    }
  )

  default = {}
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

variable "specs" {
  description = "Deployment Pod Specs"
  default     = {}
  type = map(object({
    resources = object({
      limits   = optional(map(string)),
      requests = optional(map(string)),
    }),
    nodeSelector = optional(map(string))
  }))
}

variable "labels" {
  description = "ID string and tags"
  type = object(
    {
      id   = optional(string)
      tags = optional(object({}))
    }
  )

  default = {}
}
