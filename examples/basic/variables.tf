variable "location" {
  type        = string
  description = "Azure Resource Location."
}

variable "project_identifier" {
  type        = string
  description = "Human-readable Project Identifier."
}

variable "tenant_id" {
  type        = string
  description = "Identifier of Azure Tenant."
}

variable "tfe_organization" {
  type        = string
  description = "Name of HCP Terraform Organization."
}

variable "tfe_workspace" {
  type        = string
  description = "Name of HCP Terraform Workspace."
}
