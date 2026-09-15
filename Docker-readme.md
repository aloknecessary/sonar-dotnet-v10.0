# SonarScanner for .NET 10

Optimized Docker image with **SonarScanner for .NET** preinstalled, built on the
official **.NET 10 SDK (GA)** image.

This image is intended for **CI/CD usage** (GitHub Actions, Azure DevOps, GitLab CI)
to run SonarQube or SonarCloud analysis on .NET projects.

---

## 🔧 What's Included

- .NET SDK **10.0 (stable, GA)**
- SonarScanner for .NET `6.2.0` (dotnet-sonarscanner)
- Non-root default user (`sonar`, UID 1001)
- Ubuntu-based official Microsoft image
- Multi-architecture support (amd64, arm64)

---

## 📦 Image Details

- **Docker Hub**: [Docker Hub](https://hub.docker.com/r/aloknecessary/sonar-dotnet-v10.0)
- **Source Repo**: [GitHub](https://github.com/aloknecessary/sonar-dotnet-v10.0)
- **Base Image**: `mcr.microsoft.com/dotnet/sdk:10.0`

---

## Supported Architectures

| Architecture | Supported |
| --- | --- |
| amd64 | ✅ |
| arm64 | ✅ |

Built using Docker Buildx and published as a single multi-platform manifest.

---

## 🚀 Usage

Please go to GitHub repo for usage details.

## Workspace Permissions

The image runs as the non-root `sonar` user (UID 1001). A mounted workspace may have ownership or permission settings that prevent writes.

If your runner has this issue, explicitly run the container as root:

```bash
docker run --rm --user 0 \
  -v "$(pwd):/workspace" \
  -w /workspace \
  aloknecessary/sonar-dotnet-v10.0:latest
```

For a GitHub Actions container job:

```yaml
container:
  image: aloknecessary/sonar-dotnet-v10.0:latest
  options: --user 0
```
