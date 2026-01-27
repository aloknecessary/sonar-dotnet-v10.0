# SonarScanner for .NET 10

An optimized, CI-ready Docker image with **SonarScanner for .NET** preinstalled,
built on the official **.NET 10 SDK (GA)** base image.

This image is designed for **static code analysis** of .NET projects using
**SonarQube** or **SonarCloud** in CI/CD pipelines.

---

## 🎯 Purpose

This image exists to provide a **consistent, fast, and reproducible** Sonar analysis
environment across multiple repositories and CI systems.

Instead of installing .NET SDK and SonarScanner on every pipeline run, teams can
reuse this image as a **golden CI utility image**.

---

## 🔧 What's Included

- **.NET SDK 10.0 (GA, stable)**
- **SonarScanner for .NET** (`dotnet-sonarscanner`)
- Official Microsoft Ubuntu-based image
- Multi-architecture support

> ⚠️ This image is intended **only for CI/static analysis**, not for production runtimes.

---

## 📦 Image Information

- **Docker Hub**:  
  https://hub.docker.com/r/aloknecessary/sonar-dotnet-v10.0

- **Source Repository**:  
  https://github.com/aloknecessary/sonar-dotnet-v10.0

- **Base Image**:  
  `mcr.microsoft.com/dotnet/sdk:10.0`

- **Architectures**:
  - `linux/amd64`
  - `linux/arm64`

---

## 🚀 Usage

### 1️⃣ Docker CLI (Local or CI)

```bash
docker run --rm \
  -v "$(pwd):/workspace" \
  aloknecessary/sonar-dotnet-v10.0:latest \
  dotnet sonarscanner --help
```
---
### 2️⃣ GitHub Actions Example

## Using This Image in GitHub Actions

You can use this image directly in your GitHub Actions workflow to run
SonarQube or SonarCloud analysis on .NET projects.

This image already contains:
- .NET SDK 10
- SonarScanner for .NET

No additional setup is required.

---

### Example: SonarQube / SonarCloud Scan

```yaml
name: Sonar Analysis

on:
  push:
    branches:
      - main
  pull_request:

jobs:
  sonar:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout source
        uses: actions/checkout@v4

      - name: Run SonarScanner using custom image
        uses: docker://aloknecessary/sonar-dotnet-v10.0:latest
        with:
          args: >
            dotnet sonarscanner begin
            /k:"my-project-key"
            /d:sonar.host.url=${{ secrets.SONAR_HOST_URL }}
            /d:sonar.login=${{ secrets.SONAR_TOKEN }}

      - name: Build project
        run: dotnet build

      - name: Complete Sonar analysis
        uses: docker://aloknecessary/sonar-dotnet-v10.0:latest
        with:
          args: >
            dotnet sonarscanner end
            /d:sonar.login=${{ secrets.SONAR_TOKEN }}
```

