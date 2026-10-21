# GRC Engineering Labs

Hands-on labs I built to practice GRC engineering end to end: writing controls as code, proving they work, and capturing evidence an assessor could use.

Every lab has an `evidence/` folder with the raw output that shows the control working. Anyone can open this repo in a GitHub Codespace and get the same tools I used.

## What this proves
My working environment is defined as code, rebuilt the same way every time, and the security tools in it are pinned to exact versions and checked against published checksums before they run.

## What I built
- A dev container (`.devcontainer/`) that gives every Codespace the same toolset: Docker, Terraform, AWS CLI, kubectl, Trivy and kind
- An install script that pins Trivy 0.69.3 and kind v0.33.0 and refuses to install them if the SHA-256 checksum doesn't match
- A `.gitignore` that keeps Terraform state and variable files out of Git

## Control mapping
| Control | How it's met |
|---|---|
| CM-2 Baseline Configuration | The dev container is the documented, reproducible baseline for the workbench |
| CM-3 Configuration Change Control | Every change to the workbench is a Git commit with an author, a time and a reason |
| SR-3 Supply Chain Controls and Processes | Security tools are pinned to exact versions and checksum-verified; a mismatch stops the install |

## Evidence
| File | Shows |
|---|---|
| `evidence/01-tool-versions.txt` | The exact version of every tool in the workbench |
| `evidence/02-checksums-verified.txt` | Trivy and kind passed their checksum checks |
| `evidence/03-checksum-mismatch-blocked.txt` | A tampered checksum stopped the install before anything was installed |

## Labs
| Lab | What it proves | NIST 800-53 |
|---|---|---|
| [01 Vulnerability scanning](01-vuln-scanning/) | Image and IaC scanning, SBOMs, and a CI gate that blocks critical CVEs | RA-5, SI-2, SA-11, CM-8, SR-3 |
| 02 Kubernetes policy | Planned | |
| 03 IAM least privilege | Planned | |
| 04 AWS detection | Planned | |

## Reproduce
Open this repo on GitHub, click Code, then Codespaces, then Create codespace on main. When it finishes building, run:

    trivy --version
    kind version
