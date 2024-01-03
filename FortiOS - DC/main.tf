terraform {
  required_providers {
    fortios = {
      source = "fortinetdev/fortios"
      version = "1.18.1"
    }
  }
}

provider "fortios" {
  insecure     = "true"
}