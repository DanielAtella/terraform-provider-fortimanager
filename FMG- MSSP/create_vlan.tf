resource "fortimanager_exec_workspace_action" "vlan_lockres" {
  action         = "lockbegin"
  scopetype      = "adom"
  adom           = var.customer.DummyCustumer.adom
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
}

resource "fortimanager_json_generic_api" "Create_Vlan" {
    for_each = var.new_deploy ? var.customer.DummyCustumer.interfaces : {}
    json_content = jsonencode({
        "method": "add",
        "params": [
            {
              "url": "/pm/config/device/{{var.customer.DummyCustumer.hostname}}/global/system/interface",
                "data": {
                  "name": each.value.ifname,
                  "vdom": [
                      var.customer.DummyCustumer.vdom
                  ],
                  "mode": "static",
                  "ip": [
                      each.value.address
                  ],
                  "allowaccess": "ping",
                  "type": "vlan",
                  "vlanid": each.value.vlanid,
                  "vlan-protocol": "8021q",
                  "interface": [
                      each.value.interface
                  ]
              }
            }
        ]
    })
  }

resource "fortimanager_json_generic_api" "Delete_Vlan" {
    for_each = var.new_deploy ? {} : var.customer.DummyCustumer.interfaces

    json_content = jsonencode({
      "method": "delete",
      "params" : [
        {
          "url" : "/pm/config/device/{{var.customer.DummyCustumer.hostname}}/global/system/interface",
          "confirm": 1,
          "filter": [
            "name", "in", each.value.ifname
          ]
        }
      ]
    })
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
  depends_on     = [fortimanager_json_generic_api.Create_Vlan]
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