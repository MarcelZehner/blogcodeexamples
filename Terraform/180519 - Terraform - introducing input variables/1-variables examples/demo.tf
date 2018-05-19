############################################
# Providers
############################################
provider "azurerm" {
  subscription_id = "YOUR SUBSCRIPTION ID GOES HERE"
  client_id       = "YOUR CLIENT ID GOES HERE"
  client_secret   = "YOUR CLIENT SECRET GOES HERE"
  tenant_id       = "YOUR TENANT ID GOES HERE"
}

############################################
# Variables
############################################
variable "azure_region" {
  type = "string"
  description = "Azure region for deploying new resources"
  default = "West Europe"
}
variable "environment" {
  type = "string"
  description = "Environment, either dev or prod"
  default = "dev"
}
variable "azure_rg_name" {
  type = "string"
  description = "Name of the Resource Group"
  default = "weu-dev-rg-terraformdemo-02"
}
variable "storageaccounttype" {
  type = "map"
  description = "Type of the storage account depending on environment"
  default = {
    dev = "LRS"
    prod = "GRS"
  }
}

############################################
# Resources
############################################
resource "azurerm_resource_group" "rg1" {
    name = "${var.azure_rg_name}"
    location = "${var.azure_region}"
}
resource "azurerm_storage_account" "storage1" {

    name = "${format("terra2018%s", var.environment)}"
    resource_group_name = "${azurerm_resource_group.rg1.name}"
    location = "${var.azure_region}"
    account_tier = "standard"
    account_replication_type = "${lookup(var.storageaccounttype, var.environment)}"
}