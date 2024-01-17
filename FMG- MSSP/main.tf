terraform {
  required_providers {
    fortimanager = {
      source = "fortinetdev/fortimanager"
      version = "1.9.0"
    }
  }
}

provider "fortimanager" {
  insecure     = "true"
  scopetype    = "adom"
  adom         = "root"
}

