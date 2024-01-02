resource "fortios_firewall_policy" "fw_pol1" {
  action             = var.FW.PSA.policy_action
  logtraffic         = "utm"
  name               = var.FW.PSA.policy_name
  schedule           = "always"
  wanopt             = "disable"
  wanopt_detection   = "active"
  wanopt_passive_opt = "default"
  wccp               = "disable"
  webcache           = "disable"
  webcache_https     = "disable"
  wsso               = "enable"

  dstaddr {
    name = var.FW.PSA.dstaddr
  }

  dstintf {
    name = var.FW.PSA.dstintf
  }

  service {
    name = var.FW.PSA.service
  }

  srcaddr {
    name = var.FW.PSA.srcaddr
  }

  srcintf {
    name = var.FW.PSA.srcintf
  }
}