resource "helm_release" "argo_release" {
  name       = "${var.env}-yuval-argo"
  namespace  = var.argo_namespace
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argo_cd_version
  depends_on = [var.cluster_ca_certificate ,kubernetes_namespace.argo_namespace] #[kubernetes_namespace.argo_namespace]

}

resource "kubernetes_namespace" "argo_namespace" {
  metadata {
    name = var.argo_namespace
  }
}

# resource "kubectl_manifest" "argocd_manifest" {
#   depends_on = [helm_release.argo_release]#, kubernetes_secret.argocd_ssh_key, kubernetes_secret.ecr_credentials]
#   yaml_body = <<YAML
# apiVersion: argoproj.io/v1alpha1
# kind: Application
# metadata:
#   name: infra-apps
#   namespace: argocd
# spec:
#   project: default
#   source:
#     repoURL: 'git@gitlab.com:NaorHadad/charts.git'
#     targetRevision: HEAD
#     path: ./ArgoCD/infra-apps
#   destination:
#     server: 'https://kubernetes.default.svc'
#     namespace: argo
#   syncPolicy:
#     automated:
#       prune: true
#       selfHeal: true

# YAML

# }