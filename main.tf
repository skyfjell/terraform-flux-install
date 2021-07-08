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
  target_path    = local.paths_string
  network_policy = local.network_policy
  version        = local.version

  # TODO This should be required for the module.
  toleration_keys = local.toleration_keys
}

data "kubectl_file_documents" "this" {
  content = data.flux_install.this.content
}

locals {
  # Fix inconsistent result from cpu unit conversion on apply.
  # Remove namespace doc...
  temp_documents_1 = [
    for doc in data.kubectl_file_documents.this.documents :
    yamldecode(replace(doc, "cpu: 1000m", "cpu: 1")) if length(regexall("kind: Namespace", doc)) == 0
  ]
}

locals {
  # Remove out of spec "status" property in root of document.
  temp_documents_2 = [
    for doc in local.temp_documents_1 :
    {
      for key, value in doc :
      key => value if !contains(["status"], key)
    }
  ]
}

locals {
  documents = {
    for doc in local.temp_documents_2 :
    lower(
      join("/", compact([doc.apiVersion, doc.kind, lookup(doc.metadata, "namespace", ""), doc.metadata.name]))
    ) => doc
  }
}

resource "kubernetes_manifest" "this" {
  provider = kubernetes-alpha

  for_each = local.documents

  manifest = each.value

  depends_on = [kubernetes_namespace.this]

  lifecycle {
    ignore_changes = [
      manifest.metadata.creationTimestamp,
    ]
  }
}
