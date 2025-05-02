# 🔐 Cloud Project: Secure Docker Image Deployment with Cosign & Kubernetes

This project demonstrates a secure pipeline that builds, signs, and deploys a Dockerized Node.js application to a Kubernetes cluster using `cosign` for container image signing and verification.

---

## 📦 Features

- 🛠️ Build and push Docker images with custom tags
- 🔐 Sign images using Cosign private keys
- ✅ Verify image signature before Kubernetes deployment
- ☸️ Deploy to a Kubernetes cluster only after successful verification

---

## 📁 Directory Structure
```
cloud-project/
│
├── node-demo-app/ # Node.js web app
│ ├── app.js
│ ├── Dockerfile
│ └── package.json
│
├── deployment/ # Kubernetes configs and scripts
│ ├── deployment.yaml
│ ├── service.yaml
│ └── automated-decryption-deployment.ps1 # Script to verify and deploy
|
├── automated-build-encryption.ps1 # Script to build, sign, and push image
└── .gitignore
```

---

## 🚀 Usage

1. **Build & Sign Image**  
   Run:
   ```powershell
   .\automated-build-encryption.ps1 "app folder" "image name" "tag" "your-dockerhub-user/image name" "cosign.key path"

2. **Decrypt &Deploy Image**  
   Run:
   ```powershell
   .\deployment\automated-decryption-deployment.ps1 "docker.io/your-dockerhub-user/image name:tag" "default"

## 🔐 Security

- Uses cosign to digitally sign Docker images with a private key.
- Public key is stored as a Kubernetes secret (cosign-public-key).
- Deployment proceeds only if the image signature is verified.

## 📝 Prerequisites

- Docker
- Kubernetes 
- PowerShell
- Cosign

## 🚀 Authors

- Vardaan Dua      21115155
- Akshat Chaudhary 21114009
- Soham Singh      21114099

   
