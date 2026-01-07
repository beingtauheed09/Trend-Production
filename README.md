Trend-Production: End-to-End CI/CD Pipeline
A production-ready deployment of a React application using Terraform for infrastructure, Jenkins for CI/CD, Docker for containerization, and Kubernetes (MicroK8s) for orchestration.

🚀 Project Overview
This project automates the entire lifecycle of a web application:

Infrastructure: Provisioned on AWS using Terraform.

CI/CD: Automated builds and deployments via Jenkins Pipeline.

Containerization: Dockerized React app pushed to DockerHub.

Orchestration: High-availability deployment on Kubernetes.

🛠️ Tech Stack
Frontend: React.js

Infrastructure: Terraform, AWS (VPC, EC2, IAM)

CI/CD: Jenkins, GitHub Webhooks

Containers: Docker, DockerHub

Orchestration: Kubernetes (MicroK8s)

📸 Deployment Evidence
1. CI/CD Pipeline (Jenkins)
Successfully executed declarative pipeline showing Cleanup, Checkout, Build, Push, and Deploy stages.

<img width="1919" height="1030" alt="Screenshot 2026-01-07 174452" src="https://github.com/user-attachments/assets/c2ca36c4-e71e-4109-bb47-9fe15587b515" />

2. DockerHub Repository
Docker image built and pushed to the public registry.

<img width="1919" height="1030" alt="Screenshot 2026-01-07 174721" src="https://github.com/user-attachments/assets/cc5ca5e0-dc3c-48cf-ab66-40e408cfd951" />

3. Kubernetes Cluster Status
Current state of Pods, Services, and Deployments in the cluster.

<img width="1919" height="364" alt="Screenshot 2026-01-07 175528" src="https://github.com/user-attachments/assets/e58925e6-d3c9-4262-9c6c-b6f37672e137" />

4. Live Application
Final application running in a production state.

URL: http://44.211.55.65:8081

<img width="1919" height="1029" alt="Screenshot 2026-01-07 175818" src="https://github.com/user-attachments/assets/3e8dc100-b83d-460b-954b-8a49fec1fd8d" />

🔧 Setup & Installation
Infrastructure (Terraform)
Initialize Terraform: terraform init

Apply configuration: terraform apply -auto-approve

CI/CD Setup (Jenkins)
Install plugins: Docker, Pipeline, GitHub, Kubernetes.

Add Credentials: dockerhub-credentials (Username/Password).

Configure Webhook: Add Jenkins URL to GitHub repository settings.

Kubernetes Deployment
Apply manifests: kubectl apply -f deployment.yaml

Expose Service: kubectl port-forward --address 0.0.0.0 service/trend-service 8081:80
