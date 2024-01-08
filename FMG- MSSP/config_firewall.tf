resource "fortimanager_exec_workspace_action" "fw_lockres" {
  action         = "lockbegin"
  scopetype      = "adom"
  adom           = var.customer.DummyCustumer.adom
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
}

resource "fortimanager_packages_firewall_policy" "config_fw_policy" {
  for_each = var.customer.DummyCustumer.firewall
  action                  = var.customer.DummyCustumer.firewall[each.value.policy_action]
  dstaddr                 = var.customer.DummyCustumer.firewall[each.value.dstaddr]
  dstintf                 = var.customer.DummyCustumer.firewall[each.value.dstintf]
  name                    = var.customer.DummyCustumer.firewall[each.value.policy_name]
  natip                   = var.customer.DummyCustumer.firewall.ip_pool[each.value.ip_pool_name]
  pkg                     = var.customer.DummyCustumer.firewall[each.value.policy_pkg_name]
  service                 = var.customer.DummyCustumer.firewall[each.value.service]
  srcaddr                 = var.customer.DummyCustumer.firewall[each.value.srcaddr]
  srcintf                 = var.customer.DummyCustumer.firewall[each.value.srcintf]
  status                  = "enable"
  depends_on     = [fortimanager_exec_workspace_action.fw_lockres]
}

resource "fortimanager_json_generic_api" "fw_Commit_adom" {
    json_content = <<JSON
  {
      "method": "exec",
      "params": [
          {
            "url": "/dvmdb/adom/{{var.customer.DummyCustumer.adom}}/workspace/commit"
          }
      ]
  }
  JSON
  depends_on     = [fortimanager_packages_firewall_policy.config_fw_policy]
  }

resource "fortimanager_exec_workspace_action" "fw_unlockres" {
  action         = "lockend"
  scopetype      = "adom"
  adom           = var.customer.DummyCustumer.adom
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
  depends_on     = [fortimanager_json_generic_api.fw_Commit_adom]
}

resource "fortimanager_securityconsole_install_device" "fw_Install_Device_Settings" {
  fmgadom          = var.customer.DummyCustumer.adom
  flags            = ["auto_lock_ws"]
  scope {
    name = var.customer.DummyCustumer.hostname
  }
  depends_on     = [fortimanager_exec_workspace_action.fw_unlockres]
}