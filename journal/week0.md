# Terraform Beginner Bootcamp 2023 - Week 0

# Table of contents

- [Terraform Beginner Bootcamp 2023](#terraform-beginner-bootcamp-2023)
  - [Semantic Versioning!!!](#semantic-versioning)
  - [Install Terraform CLI](#install-terraform-cli)
    - [Updated installation instructions of Terraform CLI](#updated-installation-instructions-of-terraform-cli)
    - [Prerequisites of Linux OS for installation](#prerequisites-of-linux-os-for-installation)
    - [Refactoring Terrform CLI instructions to bash script in gitpod.yml](#refactoring-terrform-cli-instructions-to-bash-script-in-gitpodyml)
      - [Shebang Considerations](#shebang-considerations)
      - [Linux script execution considerations](#linux-script-execution-considerations)
      - [Linux file permissions](#linux-file-permissions)
    - [Gitpod lifecycle considerations (before, init)](#gitpod-lifecycle-considerations-before-init)
    - [Working with Environment Variables (env var)](#working-with-environment-variables-env-var)
      - [env command](#env-command)
      - [Setting and Unsetting env vars](#setting-and-unsetting-env-vars)
      - [Scope of env vars](#scope-of-env-vars)
      - [Persisting env vars in Gitpod](#persisting-env-vars-in-gitpod)
    - [AWS CLI Installation](#aws-cli-installation)
  - [Terraform Basics](#terraform-basics)
      - [Terraform Registry](#terraform-registry)
      - [Terraform Console](#terraform-console)
      - [Terraform Init](#terraform-init)
      - [Terraform Plan](#terraform-plan)
      - [Terraform Apply](#terraform-apply)
      - [Terraform Destory](#terraform-destory)
      - [Terraform Lock Files](#terraform-lock-files)
    - [Terraform State Files](#terraform-state-files)
    - [Terraform Directory](#terraform-directory)
  - [S3 Bucket creation via Terraform Considertions](#s3-bucket-creation-via-terraform-considertions)
      - [S3 Bucket naming rules](#s3-bucket-naming-rules)
  - [Terraform Cloud Login](#terraform-cloud-login)
      - [Create a Terraform Project and Workspace with in the Project](#create-a-terraform-project-and-workspace-with-in-the-project)
      - [Terraform Cloud login issue in Gitpod.](#terraform-cloud-login-issue-in-gitpod)
      - [Automation of Terraform Cloud login](#automation-of-terraform-cloud-login)

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

### Prerequisites of Linux OS for installation

- This project is built on Ubuntu.
- Please check the Terraform documentation for installation for the Linux distribution you are using.

[How to check the Linux Distribution](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Command to check the Linux distribution
```
$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring Terrform CLI instructions to bash script in gitpod.yml

While fixing the Terraform depreciation issue, it was observed the number of code increased considerability and to keep the gitpod.yml, the installation instructions was converted to a bash script.

Bash script is located in the following location [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This keeps the Gitpod Task file ([.gitpod.yml](.gitpod.yml)) cleaner.
- This allows debugging easier.
- This code can be reused in other scripts.

#### Shebang Considerations

A [shebang](https://bash.cyberciti.biz/guide/Shebang) (pronounced Sha-bang) indicates the interpreter for execution in UNIX/Linux operating systems. This must be the first line in the Linux shell script and must start with shebang #! e.g. `#!/bin/bash`

Syntax:

```
#!/path/to/interpreter [arguments]
#!/path/to/interpreter -arg1 -arg2
```

Examples:

```
#!/bin/bash
#!/usr/bin/env bash
```

- It denotes the absolute path to **Bash interpreter**.
- `#!/bin/sh` - is the standard command interpreter for the OS.
- `#!/usr/bin/env bash` - is **recommended** as it makes your script portable as it will use whatever bash executable appears first in the running user's $PATH variable.

#### Linux script execution considerations

[4 ways of exeucting shell script in UNIX/Linux](https://www.thegeekstuff.com/2010/07/execute-shell-script/)

- Method 1: Execute shell script by specifying interpreter  e.g. ` sh ./bin/install_terraform_cli` or `bash ./bin/install_terraform_cli`
- Method 2: Execute shell script using `. ./` (dot space dot slash) notation `$ . ./scriptfile`. e.g. `. ./bin/install_terraform_cli`
- Method 3: Execute shell script using source command (this is basically Method 2, instead of `.` we are using `source`) e.g. `source ./bin/install_terraform_cli`
- Method 4: Execute shell script using the file name (for this we need to change our script file to executable, details in below section) e.g. ` ./bin/install_terraform_cli`

#### Linux file permissions

[Linux file permissions](https://www.freecodecamp.org/news/file-permissions-in-linux-chmod-command-explained/)

In order to run the script by using the file name, permissions on the script needs to be changed to executable.

**chmod** (Change mode) command can be used to change the file permissions on Linux

```
chmod <Operations> <File/Directory Name>
```

```sh
chmod u+x ./bin/install_terraform_cli
```

or you can use below command as well,

```sh
chmod 744 ./bin/install_terraform_cli
```

### Gitpod lifecycle considerations (before, init)

You need to be careful when using `init` as this will not run the files if the existing workspace is restarted

[Gitpod Tasks](https://www.gitpod.io/docs/configure/workspaces/tasks)


### Working with Environment Variables (env var)

#### env command

`env` lists all the environment variables.

Using `env | grep AWS_` will filter the output

#### Setting and Unsetting env vars

- In terminal following command sets the env var `export COURSE='tfbootcamp'`

- In terminal following command unsets the env var `unset COURSE`

- We can set the env var temporarliy while running a command

    ```sh
    COURSE='tfbootcamp' ./bin/print_text
    ```
- Within the bash script you can use env var with using the `export` command. e.g
    ```sh
    #!/bin/usr/env bash

    COURSE='tfbootcamp'

    echo $COURSE
    ```

#### Scope of env vars

The scope of env var is only on the current terminal, any new terminal will not have the env var.

If you want the env var to persistent across all terminal, you have to use bash profile to set it.

#### Persisting env vars in Gitpod

- env vars can be persisted into gitpod by storing them into Gitpod Secrets Storage.
```
gp env COURSE='tfbootcamp'
```
- env vars can also be set in `gitpod.yml` file, however it should not contain any sensitive env vars


### AWS CLI Installation

AWS CLI is installed for the project via bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Install or update the latest version of the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI env vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if the AWS Credentials is configured, by running the below AWS CLI command,

```sh
aws sts get-caller-identity
```
If the above command is successful, you will recieve output like below,

```json
{
    "UserId": "AIDA2QDEBV2JKHFN89547",
    "Account": "887766554433",
    "Arn": "arn:aws:iam::887766554433:user/tfbootcamp"
}
```

We need to genereate IAM user credentials from AWS console.

## Terraform Basics

#### Terraform Registry

Terraform Registry contains/hosts Providers and Modules and use following link to reach their website [Terraform Registry](https://registry.terraform.io/)

- **Providers** are basically a wrapper to interact with the APIs exposed by the vendor. e.g. AWS API to handle S3 bucket operations.
[Terraform Provider - Random Provider](https://registry.terraform.io/providers/hashicorp/random/latest
)

- **Modules** are collection of Terraform configurations which are portable, modular and shareable.
[Terraform Module - s3 bucket](https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest)

#### Terraform Console

We can list all the Terraform Commands by issuing following command `terraform`

```
$ terraform
Usage: terraform [global options] <subcommand> [args]

The available commands for execution are listed below.
The primary workflow commands are given first, followed by
less common or more advanced commands.

Main commands:
  init          Prepare your working directory for other commands
  validate      Check whether the configuration is valid
  plan          Show changes required by the current configuration
  apply         Create or update infrastructure
  destroy       Destroy previously-created infrastructure

All other commands:
  console       Try Terraform expressions at an interactive command prompt
  fmt           Reformat your configuration in the standard style
  force-unlock  Release a stuck lock on the current workspace
  get           Install or upgrade remote Terraform modules
  graph         Generate a Graphviz graph of the steps in an operation
  import        Associate existing infrastructure with a Terraform resource
  login         Obtain and save credentials for a remote host
  logout        Remove locally-stored credentials for a remote host
  metadata      Metadata related commands
  output        Show output values from your root module
  providers     Show the providers required for this configuration
  refresh       Update the state to match remote systems
  show          Show the current state or a saved plan
  state         Advanced state management
  taint         Mark a resource instance as not fully functional
  test          Experimental support for module integration testing
  untaint       Remove the 'tainted' state from a resource instance
  version       Show the current Terraform version
  workspace     Workspace management

Global options (use these before the subcommand, if any):
  -chdir=DIR    Switch to a different working directory before executing the
                given subcommand.
  -help         Show this help output, or the help for a specified subcommand.
  -version      An alias for the "version" subcommand.
```

#### Terraform Init

- This is the first command that should be run after writing a Terraform Configuration.
- This setups the Terraform backend by downloading necessary providers and modules.

`terraform init`

#### Terraform Plan

- This command generates an execution plan which will display the changes that will be applied to our infrastructure.
- We can store the changes to a file and can be used as input to `terraform apply`

`terraform plan`

#### Terraform Apply

- This command runs the `terraform plan` and applies the changes to the infrastructure.
- You will be prompted to approve the changes and it can be automated by using 'auto-approve' option.

`terraform apply`
`terraform apply --auto-approve`

#### Terraform Destory

- This command `terraform destroy` will destroy the resources that were deployed via the Terraform project.


#### Terraform Lock Files

- This files locks(stores) the version of providers and modules which are compatible with the current project.
- This file **should be committed** to your Version Control System (VCS) e.g. github

`.terraform.lock.hcl`

### Terraform State Files

- This file contains the current state of your infrastructure.
- This file might contain sensitive data
- This file **should not be committed** to your Version Control System (VCS) e.g. github

`.terraform.tfstate` - Current state
`.terraform.tfstate.backup` - Previous state

### Terraform Directory

- This directory contains the binaries of the Providers and Modules that is used in the project.


## S3 Bucket creation via Terraform Considertions

#### S3 Bucket naming rules

[Bucket naming rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html)

We had issue in creating bucket as the bucket name generated by **Terraform Random** provider had uppercase letters in it. Upon checking the AWS documentation, found below naming rules for the S3 bucket.

- Bucket names must be between 3 (min) and 63 (max) characters long.
- Bucket names can consist only of lowercase letters, numbers, dots (.), and hyphens (-).
- Bucket names must begin and end with a letter or number.

## Terraform Cloud Login

#### Create a Terraform Project and Workspace with in the Project

- Head over to [Terraform Cloud website](https://app.terraform.io/), and create a new Project and within the Project create a new workspace, once the workspace is created, copy the Cloud integration code block and add it to the main.tf file. e.g

```
terraform {
  cloud {
    organization = "TFBC"

    workspaces {
      name = "terra-house-1"
    }
  }
}
```
- Now, run following command `terraform login`, it will display a URL from where the API token needs to be generated, once generated copy it and paste it in the onscreen display.

[Terraform Login URL](https://app.terraform.io/app/settings/tokens?source=terraform-login)

- The API token will be saved in the following path '/home/gitpod/.terraform.d/credentials.tfrc.json'

#### Terraform Cloud login issue in Gitpod.

Pasting the API token to the onscreen prompt didn't work in Gitpod, so the follwing steps were done,

- Create the Terraform Credentials file and open in VSCode

```bash
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

- In the credentials file paste your Terraform Cloud API token as per below example

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "Your_Terraform_Cloud_API_Token"
    }
  }
}
```

#### Automation of Terraform Cloud login

As we had issue in login to Terraform Cloud in Gitpod, we have created a bash script [./bin/generate_tfrc_credentials](./bin/generate_tfrc_credentials)