terraform {
  required_providers {
    fortimanager = {
      source = "fortinetdev/fortios"
      version = "1.9.0"
    }
  }
}

provider "fortimanager" {
  hostname     = "192.168.216.137"
  token        = "7jsrdzt3c3w3q9hjQ9G49pN77mx8Gt"
  insecure     = "true"
}