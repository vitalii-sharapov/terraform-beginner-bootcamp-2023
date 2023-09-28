# Terraform Beginner Bootcamp 2023 - Week 1

![Funny](https://github.com/vitalii-sharapov/terraform-beginner-bootcamp-2023/assets/90422092/725e9e2e-693e-4700-8bff-e36389eaa500)


## Root Module Structure

Our root module structure is as follows:

```sh
PROJECT_ROOT
.
├── README.md         -  # required for root modules
├── main.tf           -  # everything else
├── variables.tf      -  # stores the structure of input variables
├── outputs.tf        -  # stores our outputs
├── terraform.tfvars  -  # the data we want to load into our terraform project
```

[Root Module Structure Documentation](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
