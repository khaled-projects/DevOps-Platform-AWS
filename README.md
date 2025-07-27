# Enterprise DevOps Platform on AWS

Ce projet simule une vraie plateforme DevOps d'entreprise avec une approche mixte : Kubernetes (EKS) **et Serverless**. Il permet de démontrer toutes les compétences clés DevOps : IaC, CI/CD, monitoring, sécurité, et automatisation.

---

## 🎯 Objectifs

1. **Infrastructure as Code (IaC)** avec **Terraform** et **Serverless Framework**
2. **CI/CD Sécurisé** avec **GitHub Actions**
3. **Monitoring & Logs** avec **Prometheus**, **Grafana**, **CloudWatch**, **Fluent Bit**
4. **Backups Automatisés** avec **AWS Lambda + S3 + EventBridge**
5. **Architecture Hybride** : EKS pour conteneurs + Lambda pour backend
6. **DNS, IAM & Sécurité** avec **Route 53**, **IAM**, **Secrets Manager**

---

## 🧠 Technologies utilisées

### 🔧 Backend

* **Fastify** (Node.js framework ultra-rapide)
* Déployé sur **AWS Lambda** (via Serverless Framework)

### 💻 Frontend

* **React + Vite** (ou **Next.js** statique)
* Déployé sur **S3 + CloudFront** (serverless hosting)

### 📦 Conteneurisation

* **Amazon EKS** (Fargate + EC2)
* Docker, Helm pour déploiement

### ⚙️ DevOps & Automatisation

* **Terraform** (EKS, VPC, IAM, S3, Route53...)
* **Serverless Framework** (Lambda, API Gateway, DynamoDB...)
* **GitHub Actions** (CI/CD pour Docker & Lambda)

---

## 📐 Architecture Générale

```text
 Utilisateur
     |
  Route 53 (domain.example.com)
     ↓
  ┌────────────────────────────────────────────────┐
  │           AWS Infrastructure                   │
  │                                                │
  │  ┌───────────────┐       ┌───────────────────┐ │
  │  │ CloudFront    │──────▶│ S3: Frontend SPA  │ │
  │  └───────────────┘       └───────────────────┘ │
  │         │                                      │
  │         ▼                                      │
  │  API Gateway ───────▶ Lambda (Fastify API)     │
  │                                                │
  │  EKS (Helm charts: React + Node en containers) │
  │     ├─ React container                          │
  │     └─ Node.js API container                   │
  │                                                │
  │  MySQL (pod EKS)                               │
  │  Backups → S3 (Lambda déclenchée par Event)    │
  └────────────────────────────────────────────────┘

Monitoring : Prometheus, Grafana, Fluent Bit → CloudWatch Logs
```

---

## 📂 Structure du dépôt

```text
aws-devops-platform/
├─ infra/                   # Terraform (EKS, VPC, IAM, Route53...)
│  ├─ modules/
│  ├─ main.tf
│  └─ variables.tf
│
├─ serverless/              # Serverless Framework (backend API)
│  ├─ handler.js
│  └─ serverless.yml
│
├─ app/
│  ├─ frontend/             # React app (Vite ou Next.js)
│  │  ├─ Dockerfile         # Optionnel pour conteneurisation
│  │  └─ src/
│  └─ backend-container/    # Node.js app pour EKS
│     ├─ Dockerfile
│     └─ src/
│
├─ charts/                  # Helm charts (frontend + backend EKS)
│  ├─ frontend-chart/
│  └─ backend-chart/
│
├─ lambda/
│  └─ backup/
│     ├─ handler.py
│     └─ requirements.txt
│
├─ monitoring/
│  └─ manifests/            # Prometheus & Grafana configs
│     ├─ prometheus-values.yaml
│     └─ grafana-values.yaml
│
├─ ci/
│  └─ .github/workflows/
│     └─ cicd.yaml          # GitHub Actions Pipeline
│
└─ README.md
```

---

## 🚀 Lancer le projet

### 1. Pré-requis

* AWS CLI configurée (`aws configure`)
* Docker, Node.js, Terraform, Serverless Framework, Helm installés

### 2. Provisionner l'infrastructure (EKS, S3, Route53...)

```bash
cd infra/
terraform init
terraform apply
```

### 3. Déployer l’API Lambda (Serverless Backend)

```bash
cd serverless/
serverless deploy --aws-profile devops-platform
```

### 4. Build + push images Docker frontend/backend (EKS)

```bash
cd app/frontend && docker build -t frontend:latest .
cd app/backend-container && docker build -t backend:latest .
```

### 5. Déployer via Helm (dans EKS)

```bash
helm upgrade --install frontend charts/frontend-chart -n devops
helm upgrade --install backend charts/backend-chart -n devops
```

### 6. Consulter les outils de monitoring

* Grafana (port-forward ou Ingress)
* CloudWatch Logs (via Fluent Bit)

### 7. Tester les backups automatisés

* Vérifier que Lambda → S3 fonctionne via EventBridge ou CloudWatch Events

---

## ✅ Étapes suivantes

* Ajouter un domaine Route 53 + certificat SSL ACM
* Ajouter GitHub Actions secrets pour déploiement automatique
* Tester les erreurs, monitoring, alertes CloudWatch
* Simuler perte de base pour vérifier les backups

---

## 💡 Bonus

* Ajouter un dashboard Grafana avec alertes emails
* Ajouter un webhook Slack ou Discord pour les alertes
* Ajouter une table DynamoDB pour simuler un autre service Serverless


