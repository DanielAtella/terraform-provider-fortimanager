resource "fortimanager_exec_workspace_action" "adom_lockres" {
  count = var.new_deploy == false ? 1 : 0
  action         = "lockbegin"
  scopetype      = "adom"
  adom           = var.customer.DummyCustumer.adom
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
}

resource "fortimanager_dvmdb_adom" "trname" {
  name                       = var.customer.DummyCustumer.adom
  os_ver                     = "7.0"
  state          = 1
  workspace_mode = 1
}