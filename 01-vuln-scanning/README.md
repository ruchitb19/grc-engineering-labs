# 01: Vulnerability scanning and a CI gate

## What this proves
Vulnerabilities are found before deployment, in both images and infrastructure code, and a pipeline gate blocks images with critical CVEs until they're fixed.

## What I built
- Local image scanning and CycloneDX SBOM generation with Trivy
- A rescan from the SBOM alone, without the image
- IaC misconfiguration scanning of a deliberately misconfigured Terraform practice file (`iac/`, never applied)
- A GitHub Actions workflow that builds the image and fails on CRITICAL findings
  - `actions/checkout` pinned to a full commit SHA
  - Scanner run from a container image pinned by version and digest (`aquasec/trivy:0.69.3@sha256:…`, the known-safe version named in the March 2026 Trivy advisory, GHSA-69fq-xp46-6x23)
  - Least-privilege workflow token (`contents: read`)

## Control mapping
| Control | How it's met |
|---|---|
| RA-5 Vulnerability Monitoring and Scanning | Image, SBOM, and IaC scans |
| SI-2 Flaw Remediation | Failing image fixed and re-verified in CI |
| SA-11 Developer Testing and Evaluation | Security testing runs on every relevant push |
| CM-8 System Component Inventory | SBOM records every package in the image |
| SR-3 Supply Chain Controls and Processes | Actions and tools pinned to immutable or known-safe references |

## Evidence
| File | Shows |
|---|---|
| `evidence/01-nginx-image-scan.txt` | HIGH and CRITICAL findings in a public image |
| `evidence/02-nginx-sbom.cdx.json` | CycloneDX SBOM |
| `evidence/03-sbom-rescan.txt` | Vulnerability check run from the SBOM alone |
| `evidence/04-app-image-scan.txt` | My own image scanned before it went to CI |
| `evidence/05-iac-scan-practice.txt` | Misconfigurations found in the Terraform practice file |
| `evidence/06-ci-blocked-critical.txt` | Pipeline blocking the outdated image |
| `evidence/07-ci-history.txt` | Passing run, blocked run, then the passing fix |

See the Actions tab for the full run history.

## Reproduce
From this folder, in a Codespace on this repo:

    trivy image --severity HIGH,CRITICAL nginx:1.27
    trivy image --format cyclonedx --output evidence/02-nginx-sbom.cdx.json nginx:1.27
    trivy sbom --severity CRITICAL evidence/02-nginx-sbom.cdx.json
    docker build -t csl-app:local app
    trivy image --severity HIGH,CRITICAL csl-app:local
    trivy config iac

The CI gate runs on any push that changes `app/` or the workflow file.
