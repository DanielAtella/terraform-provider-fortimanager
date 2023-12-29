resource "fortimanager_exec_workspace_action" "lockres" {
  action         = "lockbegin"
  scopetype      = "adom"
  adom           = "DummyAdom"
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
}

resource "fortimanager_json_generic_api" "Create_Vlan_100" {
    json_content = <<JSON
  {
    "method": "add",
    "params": [
      {
        "data": [
                  {
                      "devid": "TPL1FWCO003",
                      "name": "{{C-TEST}}",
                      "opmode": 1,
                      "vpn_id": 0
                  }
              ],
        "url": "/dvmdb/adom/{{DummyAdom}}/device/{{Hostname_1801F}}/vdom"
      }
    ],
    "session": "{{sessionVariable}}",
    "verbose": 1,
    "id": 1
  }
  JSON
  }

resource "fortimanager_json_generic_api" "Commit_adom" {
    json_content = <<JSON
  {
      "method": "exec",
      "params": [
          {
            "url": "/dvmdb/adom/DummyAdom/workspace/commit"
          }
      ]
  }
  JSON
  depends_on     = [fortimanager_json_generic_api.Create_Vlan_100]
  }

resource "fortimanager_exec_workspace_action" "unlockres" {
  action         = "lockend"
  scopetype      = "adom"
  adom           = "DummyAdom"
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
  depends_on     = [fortimanager_json_generic_api.Commit_adom]
}

resource "fortimanager_securityconsole_install_device" "Install_Device_Settings" {
  fmgadom          = "DummyAdom"
  flags            = ["auto_lock_ws"]
  scope {
    name = "FGT2-N1"
  }
  depends_on     = [fortimanager_exec_workspace_action.unlockres]
}