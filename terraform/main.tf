terraform {
    backend "azurerm" {
        resource_group_name  = "tfstate-store-group"
        storage_account_name = "demotfstatestore"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.29.0"
    }
  }
}

provider "azurerm" {
  version = "3.29.0"
  features {}
}

resource "azurerm_resource_group" "demo_rg" {
  name     = "demo-rg"
  location = "UAE North"
}

resource "azurerm_sql_server" "demo_sql_serv" {
  name                         = "demo-sql-serv"
  location                     = azurerm_resource_group.demo_rg.location
  resource_group_name          = azurerm_resource_group.demo_rg.name
  version                      = "12.0"
  administrator_login          = var.db_user
  administrator_login_password = var.db_pass


  tags = {
    environment = "demo"
  }
}

resource "azurerm_sql_database" "sql_database" {
  name                = "test"
  resource_group_name = azurerm_resource_group.demo_rg.name
  location            = azurerm_resource_group.demo_rg.location
  server_name         = azurerm_sql_server.demo_sql_serv.name
  edition             = "Free"

  tags = {
    environment = "demo"
  }
}

resource "azurerm_container_group" "demo_container" {
  name                = "demo_app"
  location            = azurerm_resource_group.demo_rg.location
  resource_group_name = azurerm_resource_group.demo_rg.name
  ip_address_type     = "Public"
  dns_name_label      = "demo-app"
  os_type             = "Linux"

  container {
    name   = "demo-app"
    image  = "sunshine2050/demo-app:${var.image_build}"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 5000
      protocol = "TCP"
    }
  }

  diagnostics {
    log_analytics {
      workspace_id  = azurerm_log_analytics_workspace.demo_logs.workspace_id
      workspace_key = azurerm_log_analytics_workspace.demo_logs.primary_shared_key
    }
  }

  tags = {
    environment = "demo"
  }
}