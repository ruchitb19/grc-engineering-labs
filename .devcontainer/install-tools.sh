#!/usr/bin/env bash
# Installs the two tools the dev container features don't cover,
# pinned to exact versions and checked against published checksums.
set -euo pipefail

TRIVY_VERSION="0.69.3"
TRIVY_SHA256="1816b632dfe529869c740c0913e36bd1629cb7688bd5634f4a858c1d57c88b75"
KIND_VERSION="v0.33.0"
KIND_SHA256="aee6151561422756b764a4ae28e7f44cda5af5a9eead3cc9985112b1de8d8e0d"

cd /tmp

curl -sSLo trivy.tgz "https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz"
echo "${TRIVY_SHA256}  trivy.tgz" | sha256sum -c -
sudo tar -xzf trivy.tgz -C /usr/local/bin trivy
rm trivy.tgz

curl -sSLo kind "https://github.com/kubernetes-sigs/kind/releases/download/${KIND_VERSION}/kind-linux-amd64"
echo "${KIND_SHA256}  kind" | sha256sum -c -
chmod +x kind
sudo mv kind /usr/local/bin/kind

echo "Tools installed:"
trivy --version | head -n 1
kind version
