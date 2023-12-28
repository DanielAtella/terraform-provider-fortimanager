resource "fortimanager_exec_workspace_action" "lockres" {
  count = var.new_deploy == false ? 1 : 0
  action         = "lockbegin"
  scopetype      = "adom"
  adom           = "DummyAdom"
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
}

resource "fortimanager_dvmdb_adom" "trname" {
  name                       = "DummyAdom"
  os_ver                     = "7.0"
  state          = 1
  workspace_mode = 1
}