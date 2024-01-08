resource "fortimanager_exec_workspace_action" "vdom_lockres" {
  action         = "lockbegin"
  scopetype      = "adom"
  adom           = var.customer.DummyCustumer.adom
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
}

resource "fortimanager_json_generic_api" "Create_Vdom" {
    json_content = <<JSON
  {
    "method": "add",
    "params": [
      {
        "url": "/dvmdb/adom/{{var.customer.DummyCustumer.adom}}/device/{{var.customer.DummyCustumer.hostname}}/vdom",
        "data": {
                      "devid": {{var.customer.DummyCustumer.hostname}},
                      "name": {{var.customer.DummyCustumer.vdom}},
                      "opmode": 1,
                      "vpn_id": 0
                }
      }
    ]
  }
  JSON
  }

resource "fortimanager_json_generic_api" "Commit_adom_create_vdom" {
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
  depends_on     = [fortimanager_json_generic_api.Create_Vdom]
  }

resource "fortimanager_exec_workspace_action" "vdom_unlockres" {
  action         = "lockend"
  scopetype      = "adom"
  adom           = var.customer.DummyCustumer.adom
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
  depends_on     = [fortimanager_json_generic_api.Commit_adom_create_vdom]
}

resource "fortimanager_securityconsole_install_device" "vdom_Install_Device_Settings" {
  fmgadom          = var.customer.DummyCustumer.adom
  flags            = ["auto_lock_ws"]
  scope {
    name = var.customer.DummyCustumer.hostname
  }
  depends_on     = [fortimanager_exec_workspace_action.vdom_unlockres]
}