locals {
 policy = flatten([
   for firewall_key, firewall_value in var.customer.DummyCustumer.firewall : [
     for policy_key, policy_value in firewall_value.policy : {
       firewall_key      = firewall_key
       policy_key = policy_key
       policy_value = policy_value
     }
   ]
 ])
 interfaces = flatten([
   for zone_key, zone_value in var.customer.DummyCustumer.zone : [
     for interface_key, interface_value in zone_value.interfaces : {
       zone_key      = zone_key
       interface_key = interface_key
       interface_value = interface_value
     }
   ]
 ])
}

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
  # for_each = var.customer.DummyCustumer.firewall.FGT8_FG-traffic.policy
  for_each = { for i in local.policy : "${i.firewall_key}-${i.policy_key}" => i.policy_value }
  action                  = each.value.policy_action
  dstaddr                 = each.value.dstaddr
  dstintf                 = each.value.dstintf
  name                    = each.value.policy_name
  natip                   = each.value.ip_pool_name
  pkg                     = each.value.policy_pkg_name
  service                 = each.value.service
  srcaddr                 = each.value.srcaddr
  srcintf                 = each.value.srcintf
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