variable "name" {
  description = "Cluster Name"
  default     = "default"
  type        = string
}

variable "namespace" {
  description = "Namespace to Install/Create"
  default     = "flux-system"
  type        = string
}

variable "create_namespace" {
  description = "Create Namespace?"
  default     = true
  type        = bool
}

variable "tolerations" {
  description = "Toleration Keys for Components"
  default     = []
  type        = list(map(string))
}

variable "node_selector" {
  description = "Node Selector for Components"
  default     = {}
  type        = map(string)
}

variable "chart_version" {
  description = "Flux Chart Version"
  default     = "1.3.0"
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
