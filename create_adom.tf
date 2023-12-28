resource "fortimanager_exec_workspace_action" "lockres" {
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

resource "fortimanager_exec_workspace_action" "unlockres" {
  action         = "lockend"
  scopetype      = "adom"
  adom           = "DummyAdom"
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
  depends_on     = [fortimanager_dvmdb_adom.trname]
}