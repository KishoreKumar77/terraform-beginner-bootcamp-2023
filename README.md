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
