# --- Build Stage: Install SonarScanner CLI for .NET ---
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS builder

ARG SONAR_SCANNER_VERSION=6.2.0

WORKDIR /opt

# Install SonarScanner for .NET locally
RUN dotnet tool install --tool-path /opt/sonar \
    dotnet-sonarscanner --version ${SONAR_SCANNER_VERSION}

# --- Final Stage: Runtime Image ---
FROM mcr.microsoft.com/dotnet/sdk:10.0

LABEL org.opencontainers.image.title="SonarScanner for .NET 10"
LABEL org.opencontainers.image.description="Optimized SonarScanner image for .NET 10"
LABEL org.opencontainers.image.source="https://github.com/aloknecessary/sonar-dotnet-v10.0"
LABEL org.opencontainers.image.authors="aloknecessary"

ENV PATH="/opt/sonar:${PATH}"

WORKDIR /workspace

# Copy the installed Sonar tools
COPY --from=builder /opt/sonar /opt/sonar

# Run analysis without root privileges by default
RUN useradd -u 1001 -m sonar && \
    install -d -o sonar -g sonar /workspace
USER sonar

# Default entrypoint
CMD ["dotnet", "sonarscanner"]
