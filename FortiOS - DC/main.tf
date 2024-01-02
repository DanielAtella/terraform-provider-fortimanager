terraform {
  required_providers {
    fortios = {
      source = "fortinetdev/fortios"
      version = "1.18.1"
    }
  }
}

provider "fortios" {
  hostname     = "192.168.216.137"
  token        = "7jsrdzt3c3w3q9hjQ9G49pN77mx8Gt"
  insecure     = "true"
}