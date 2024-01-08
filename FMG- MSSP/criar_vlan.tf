resource "fortimanager_exec_workspace_action" "vlan_lockres" {
  action         = "lockbegin"
  scopetype      = "adom"
  adom           = var.customer.DummyCustumer.adom
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
            "url": "/pm/config/device/{{var.customer.DummyCustumer.hostname}}/global/system/interface",
              "data": {
                "name": {{var.customer.DummyCustumer.interfaces.FGT8-NET1["ifname"]}},
                "vdom": [
                    {{var.customer.DummyCustumer.vdom}}
                ],
                "mode": "static",
                "ip": [
                    {{var.customer.DummyCustumer.interfaces.FGT8-NET1["address"]}}
                ],
                "allowaccess": "ping",
                "type": "vlan",
                "vlanid": {{var.customer.DummyCustumer.interfaces.FGT8-NET1["vlanid"]}},
                "vlan-protocol": "8021q",
                "interface": [
                    {{var.customer.DummyCustumer.interfaces.FGT8-NET1["interface"]}}
                ]
            }
          }
      ]
  }
  JSON
  }

resource "fortimanager_json_generic_api" "vlan_Commit_adom" {
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
  depends_on     = [fortimanager_json_generic_api.Create_Vlan_100]
  }

resource "fortimanager_exec_workspace_action" "vlan_unlockres" {
  action         = "lockend"
  scopetype      = "adom"
  adom           = var.customer.DummyCustumer.adom
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
  depends_on     = [fortimanager_json_generic_api.vlan_Commit_adom]
}

resource "fortimanager_securityconsole_install_device" "vlan_Install_Device_Settings" {
  fmgadom          = var.customer.DummyCustumer.adom
  flags            = ["auto_lock_ws"]
  scope {
    name = var.customer.DummyCustumer.hostname
  }
  depends_on     = [fortimanager_exec_workspace_action.vlan_unlockres]
}