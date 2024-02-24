terraform {
  # see https://developer.hashicorp.com/terraform/language/settings/terraform-cloud
  cloud {
    # The Terraform Cloud configuration will be retrieved from the executing environment
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements
  required_providers {
    # see https://registry.terraform.io/providers/hashicorp/azurerm/3.84.0/
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.84.0, < 4.0.0"
    }
  }

  # see https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version
  required_version = ">= 1.7.0, < 2.0.0"
}
