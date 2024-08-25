#!/bin/bash



terraform state rm module.argocd.kubernetes_namespace.argo_namespace
terraform state rm module.argocd.helm_release.argo_release
terraform destroy -var-file="values.tfvars" -auto-approve