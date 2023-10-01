# Terraform Beginner Bootcamp 2023

## Semantic Versioning!!!

We are going to follow Semantic Versioning for tagging in this project.

[Semantic Versioning](https://semver.org/)

General format for semantic versioning is as follows:

**MAJOR.MINOR.PATCH** , e.g. `1.0.0`

- **MAJOR** version when you make incompatible API changes.
- **MINOR** version when you add functionality in a backward compatible manner.
- **PATCH** version when you make backward compatible bug fixes.

## Install Terraform CLI

### Updated installation instructions of Terraform CLI
Terraform installation instruction is changed in the gitpod.yml as we are installing GPG key ring from Terraform to fix the key warning when installing, with reference to below Terraform documentation.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Refactoring Terrform CLI instructions to bash script in gitpod.yaml

https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/
https://bash.cyberciti.biz/guide/Shebang
https://www.redhat.com/sysadmin/linux-file-permissions-explained
https://www.gitpod.io/docs/configure/workspaces/workspace-lifecycle