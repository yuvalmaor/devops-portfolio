# DevOps Application

<img src="images/todo.webp" alt="Logo" width="200"/>

## Overview

This repository contains the source code and configuration files for the `Todo` DevOps application. This application is designed to streamline and provide source for DevOps full pipeline. including CI/CD pipelines, infrastructure provisioning, monitoring, and logging.

## Architecture

Below is a high-level overview of the architecture of this application:

![Architecture Diagram](images/architecture.jpeg)

### Components

1. **CI/CD Pipeline**: Automates the process of code integration and deployment.
2. **Infrastructure as Code (IaC)**: Manages infrastructure using Terraform, Kubernetes manifests, and Helm charts.
3. **Monitoring and Logging**: Uses Prometheus, Grafana, and Loki to monitor and log application and infrastructure performance.
4. **Container Orchestration**: Kubernetes is used to manage containerized applications.
5. **Secret Management**: Securely manages secrets using HashiCorp Vault.

## Prerequisites

Before setting up this application, ensure you can use:

- Docker
- Kubernetes (EKS)
- Helm
- Terraform
- Git

## Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/yuvaldevops.git
   cd yuvaldevops
