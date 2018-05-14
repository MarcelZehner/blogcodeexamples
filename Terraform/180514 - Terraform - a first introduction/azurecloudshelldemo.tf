provider "azurerm" {
  subscription_id = "YOUR SUBSCRIPTION ID GOES HERE"
}

resource "azurerm_resource_group" "myapp" {
    name = "weu-dev-rg-terraformdemo-99"
    location = "West Europe"
}
resource "azurerm_storage_account" "myapp" {
    name = "YOUR STORAGE ACCOUNT NAME GOES HERE"
    resource_group_name = "${azurerm_resource_group.rg1.name}"
    location = "West Europe"
    account_tier = "standard"
    account_replication_type = "LRS"
}