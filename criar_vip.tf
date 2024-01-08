resource "fortimanager_exec_workspace_action" "lockres" {
  action         = "lockbegin"
  scopetype      = "adom"
  adom           = "root"
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
}

resource "fortimanager_object_firewall_vip" "trname1" {
  scopetype = "inherit"
  adom      = "root"
  extintf   = "any"
  extip     = "1.1.1.1-2.1.1.1"
  mappedip  = ["12.1.1.1-13.1.1.1"]
  name      = "viptest"
  depends_on     = [fortimanager_exec_workspace_action.lockres]
}

resource "fortimanager_exec_workspace_action" "unlockres" {
  action         = "lockend"
  scopetype      = "adom"
  adom           = "root"
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
  depends_on     = [fortimanager_object_firewall_vip.trname1]
}
