terraform {
  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.71.0, < 4.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/random/3.5.1/
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1, < 4.0.0"
    }

    # see https://registry.terraform.io/providers/hashicorp/tls/4.0.4/
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.4, < 5.0.0"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = ">= 1.6.0, < 2.0.0"
}
