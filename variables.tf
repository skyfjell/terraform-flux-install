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
  description = "Whether or not to create the namespace"
  default     = true
  type        = bool
}

variable "toleration_keys" {
  description = "Toleration keys for the flux components"
  default     = [""]
  type        = list(string)
}

variable "paths" {
  description = "Git repository path to the sync manifests"
  # Random path so we don't pick up any manifests inadvertantly
  default = ["/1f53734d-5e8d-4561-b9f2-b409499d098a/08cb5802-f420-4366-b7ea-ed1a5aa5307e"]
  type    = list(string)
}

variable "path_prefix" {
  description = "Prefix to prepend to each path"
  default     = ""
  type        = string
}
