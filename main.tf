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

  timeouts {
    delete = "30m"
  }
}

data "flux_install" "this" {
  # Random path so we don't pick up any manifests inadvertantly
  target_path     = "/1f53734d-5e8d-4561-b9f2-b409499d098a/08cb5802-f420-4366-b7ea-ed1a5aa5307e"
  network_policy  = local.network_policy
  version         = local.version
  cluster_domain  = local.cluster_domain
  toleration_keys = local.tolerations
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

  # Remove out of spec "status" property in root of document.
  temp_documents_2 = [
    for doc in local.temp_documents_1 :
    {
      for key, value in doc :
      key => value if !contains(["status"], key)
    }
  ]

  documents = {
    for doc in local.temp_documents_2 :
    lower(
      join("/", compact([doc.apiVersion, doc.kind, lookup(doc.metadata, "namespace", ""), doc.metadata.name]))
    ) =>
    # Remove `creationTimestamp` from metadata to prevent state mismatch.
    merge(doc, { metadata = { for k, v in doc.metadata : k => v if k != "creationTimestamp" } })
  }

  crd_keys = [for id, doc in local.documents : id if doc.kind == "CustomResourceDefinition"]

  crds = {
    for id in local.crd_keys : id => local.documents[id] if local.install_crds
  }

  deployment_keys = [for id, doc in local.documents : id if doc.kind == "Deployment"]

  deployments = {
    for name, doc in local.documents : name => merge(
      doc,
      {
        spec = merge(
          doc.spec,
          {
            template = merge(
              doc.spec.template,
              {
                spec = merge(
                  doc.spec.template.spec,
                  {
                    containers = [
                      merge(
                        doc.spec.template.spec.containers[0],
                        {
                          resources = {
                            limits = merge(
                              doc.spec.template.spec.containers[0].resources.limits,
                              lookup(local.resources, doc.metadata.name, doc.spec.template.spec.containers[0].resources).limits
                            ),
                            requests = merge(
                              doc.spec.template.spec.containers[0].resources.requests,
                              lookup(local.resources, doc.metadata.name, doc.spec.template.spec.containers[0].resources).requests
                            ),
                          }
                        }
                      )
                    ]
                  }
                )
              }
            )
          }
        )
      }
    ) if doc.kind == "Deployment" && local.install_controllers
  }

  remaining_keys = setsubtract(keys(local.documents), concat(local.crd_keys, local.deployment_keys))

  remaining = {
    for key in local.remaining_keys : key => local.documents[key] if local.install_controllers
  }
}

resource "kubernetes_manifest" "crds" {
  for_each = local.crds

  manifest = each.value

  depends_on = [kubernetes_namespace.this]
}

resource "kubernetes_manifest" "controllers" {
  for_each = merge(local.deployments, local.remaining)

  manifest = each.value

  depends_on = [kubernetes_manifest.crds]
}
