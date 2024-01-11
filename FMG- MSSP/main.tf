terraform {
  required_providers {
    fortimanager = {
      source = "fortinetdev/fortimanager"
      version = "1.9.0"
    }
  }
}

provider "fortimanager" {
  hostname     = "10.150.218.70"
  username     = "rest_admin"
  password     = "F0rtil4b123!"
  insecure     = "true"
  scopetype    = "adom"
  adom         = "root"
}

