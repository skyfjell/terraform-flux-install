resource "kubernetes_namespace" "this" {
  count = local.create_namespace ? 1 : 0
  metadata {
    name = local.namespace
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }
}

data "flux_install" "this" {
  target_path = local.paths_string

  # TODO This should be required for the module.
  toleration_keys = local.toleration_keys
}

data "kubectl_file_documents" "this" {
  content = data.flux_install.this.content
}

locals {
  documents = [for doc in data.kubectl_file_documents.this.documents :
    {
      data : yamldecode(doc)
      content : doc
    }
  ]
}

resource "kubectl_manifest" "flux-install" {
  for_each = { for yaml in local.documents :
    lower(
      join(
        "/",
        compact([yaml.data.apiVersion, yaml.data.kind, lookup(yaml.data.metadata, "namespace", ""), yaml.data.metadata.name]),
      )
    )
    => yaml.content
  }

  depends_on = [kubernetes_namespace.this]
  yaml_body  = each.value
}
