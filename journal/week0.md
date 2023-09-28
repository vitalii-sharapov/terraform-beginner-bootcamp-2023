# Terraform Beginner Bootcamp 2023 - Week 0

- [Terraform Beginner Bootcamp 2023 - Week 0](#terraform-beginner-bootcamp-2023---week-0)
  * [Semantic Versioning](#semantic-versioning)
  * [Install Terraform CLI](#install-terraform-cli)
    + [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
    + [Considerations for Linux distribution](#considerations-for-linux-distribution)
    + [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
    + [Shebang Considerations](#shebang-considerations)
    + [Execution Considerations](#execution-considerations)
    + [Linux Permissions Considerations](#linux-permissions-considerations)
    + [Gitpod Lifecycle (Before, Init, Command)](#gitpod-lifecycle-before-init-command-)
    + [Working Env Vars](#working-env-vars)
      - [Env command](#env-command)
      - [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
      - [Printing Vars](#printing-vars)
      - [Scoping of Env Vars](#scoping-of-env-vars)
      - [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
  * [AWS CLI Installation](#aws-cli-installation)
  * [Terraform Basics](#terraform-basics)
    + [Terraform Registry](#terraform-registry)
    + [Terraform Console](#terraform-console)
    + [Terraform Init](#terraform-init)
    + [Terraform Plan](#terraform-plan)
    + [Terraform Apply](#terraform-apply)
    + [Terraform Destroy](#terraform-destroy)
    + [Terraform Lock Files](#terraform-lock-files)
    + [Terraform State Files](#terraform-state-files)
    + [Terraform Directory](#terraform-directory)
  * [Issues with Terraform Cloud Login and Gitpod Workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)
  * [Github CLI and resolvers](#github-cli-and-resolvers)


## Semantic Versioning
This project is going utilize semantic versioning for its tagging.

[semver.org](https://semver.org)

The general format:

 **MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. 
So we needed refer to the latest CLI instructions via Terraform documentation and change the scripting for install.
[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux distibution

This project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly to distibution needs.

[How to check Linux type](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS version:

```
cat /etc/os-release

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

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg deprecation issues we 
noticed that  bash scripts steps were a considerable amount more code. 
So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allow us an easier to debug and execute manually Terraform CLI install
- This will allow better portability for other projects that need to install Terraform CLI.

### Shebang Considerations

A Shebang (pronounced Sha-bang) tells the bash script what program that will interpret the script, eg. `#!/bin/bash`

ChapGPT recommended this format for bash: `#!/usr/bin/env bash`

- for portability for different OS distributions
- will search the user's PATH for the bash executable

[Shebang Wiki](https://en.wikipedia.org/wiki/Shebang_(Unix))


### Execution Considerations

When executing the bash script we can use the `./` shorthand notation to execute the bash script.

eg. `./bin/install_terraform_cli`

if we are using a script in .gitpod.yml we need to point the script to a program to interpret it.

eg. `source ./bininstall_terraform_cli`


### Linux Permissions Considerations

In order to make our bash scripts execitable we need to change linux permission for hte fix to be executable.
```sh
chmod u+x ./bin/install_terraform_cli
```
alternatively:
```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

### Gitpod Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks


### Working Env Vars

#### Env command

We can list out all Environment Variables (Env Vars) using the `env` command

We can filter specific env vars using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO=world`

In the terminal we unset using `unset HELLO`

We can set an env var temporarily when just running a command

```sh
HELLO=`world` ./bin/print_message
```
Within a bash script we can set env without writing export eg.

```sh
#!/usr/bin/env bash
HELLO=`world`

echo $HELLO
```

[Set and Unset ENV Var](https://www.cyberciti.biz/faq/linux-osx-bsd-unix-bash-undefine-environment-variable/)

#### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars

When you open up new bash terminals in VSCOde it will not be aware of env vars that you have set in another window.

If you want to Env Vars to presist across all future bash terminals that are open, you need to set env vars in you bash profile. eg. `.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

YOu can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive env vars.

## AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

We can check if our AWS credentials configured correctly by running the following AWS CLI Command:

```sh
aws sts get-caller-identity
```

If it is successful you should see a json payload return that looks like this:

```json
{
    "UserId": "A0D012R634R5678T9012K",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credentials from IAM User in order to use AWS CLI.

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the [Terraform registry](https://registry.terraform.io)

- **Providers** is an interface to APIs that will allow to create resources in terraform.
[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random)

- **Modules** are a way to make large amounts of terraform code modular, portable and sharable.

### Terraform Console

We can see a list of all the Terraform commands by simply typing `terraform`


### Terraform Init

At the start of a new terraform project we will run `terraform init` to download the binaries for the terraform providers that we'll use in this project.


### Terraform Plan

`terraform plan`

This will generate out a changeset about the state of our infrastructure and what will be changed.

We can output this changeset ie.  "plan" to be passed to and apply, but often you can just ignore outputting.

### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be executed by terraform. Apply should prompt yes or no.

If we want to automatically approve an apply we can provide the auto approve flag eg. `terraform apply --auto-approve`.

### Terraform Destroy

`terraform destroy`
This will destroy resources.

You can also use the auto approve flag to skip the approve prompt eg. `terraform destroy --auto-approve`

### Terraform Lock Files

`terraform.local.hcl` contains ther locked versioning for the providers or modules that should be used with this project.

The Terraform Lock File **should be committed** to your Version Control System (VSC) eg. Github

### Terraform State Files

`.terraform.tfstate` contains information about the current state of your infrastructure.

This file **should not be committed** to your VCS.

This file can contain sensitive data.

If you lose this file, you lose knowing the state of your infrastructure.

`.terrafrom.tfstate.backup` is the previous state file state.

### Terraform Directory

`.terraform` directory contains binaries of terraform providers.

## Issues with Terraform Cloud Login and Gitpod Workspace

When attempting to run `terraform login` it will launch bash a wiswig view to generate a token.
However it does not work as expected in Gitpod VSCode in the browser.

The workaround is manually generate a token in Terraform Cloud

```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

In Gitpod VSCode in the browser, type `terraform login`, screen will become black with some options represented,
click `p`, the link to generate new token will be shown. Use link to generate new token, copy it.
Return to Gitpod, hit `q` to quit and system will prompt you to enter token value, see screen below where to enter new token:

![Paste token generated in Terraform Cloud](https://github.com/vitalii-sharapov/terraform-beginner-bootcamp-2023/assets/90422092/198a52ac-1096-4fc3-875c-47f7cbf17a1a)

Right click on mouse and click in prompted window `Allow` to paste in browser. 
This will paste token. Hit `Enter` and credentials will be processed.

This is the screen you will see once all done!

![Welcome text from Terraform upon successful login using token](https://github.com/vitalii-sharapov/terraform-beginner-bootcamp-2023/assets/90422092/4998778e-814d-4be9-ae5a-1eabc36cbce5)


We have automated this workaround with the following bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)




## Github CLI and resolvers 

In the event when the labor started without creating new issue and work was going on in main branch,
in order to switch added or changed data from main branch to new branch follow these steps:
```sh
git pull                    # Use pull to make sure all data is loaded here
git fetch                   # double check its loaded, always good since we already screwed this
git stash save              # This command will save all data that was applied in VSCode, but **yet not committed to main**
git checkout new-branch     
git stash apply             # Will Apply data that was saved to a new branch instead of main
```

[`git stash` Documentation](https://git-scm.com/docs/git-stash)

