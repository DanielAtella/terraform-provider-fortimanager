locals {
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
  for_each = var.new_deploy ? { for i in local.interfaces : "${i.zone_key}-${i.interface_key}" => i.interface_value } : {}
  json_content = jsonencode({
    "method": "add",
    "params": [
      {
        "url": "/pm/config/device/${var.customer.DummyCustumer.hostname}/global/system/interface",
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
for_each = var.new_deploy ? { for i in local.interfaces : "${i.zone_key}-${i.interface_key}" => i.interface_value } : {}

    json_content = jsonencode({
      "method": "delete",
      "params" : [
        {
          "url" : "/pm/config/device/${var.customer.DummyCustumer.hostname}/global/system/interface",
          "confirm": 1,
          "filter": [
            "name", "in", each.value.ifname
          ]
        }
      ]
    })
  }

resource "fortimanager_json_generic_api" "Create_zone" {
    for_each = var.new_deploy ? var.customer.DummyCustumer.interfaces : {}
    json_content = jsonencode({
        "method": "add",
        "params": [
            {
              "url": "/pm/config/device/${var.customer.DummyCustumer.hostname}/vdom/${var.customer.DummyCustumer.vdom}/system/zone",
                "data": {
                  "name": each.key.zone,
                  "intrazone": "deny",
                  "mode": "static",
                  "interface": [
                    each.value.zone == each.value.zone ? each.value.ifname : ""
                  ]
              }
            }
        ]
    })
    }


resource "fortimanager_json_generic_api" "Delete_Zone" {
    for_each = var.new_deploy ? {} : var.customer.DummyCustumer.interfaces

    json_content = jsonencode({
      "method": "delete",
      "params" : [
        {
          "url" : "/pm/config/device/${var.customer.DummyCustumer.hostname}/vdom/${var.customer.DummyCustumer.vdom}/system/zone",
          "confirm": 1,
          "filter": [
            "name", "in", each.value.zone
          ]
        }
      ]
    })
  }

resource "fortimanager_json_generic_api" "vlan_Commit_adom" {
    json_content = jsonencode({
   {
      "method": "exec",
      "params": [
          {
            "url": "/dvmdb/adom/${var.customer.DummyCustumer.adom}/workspace/commit"
          }
      ]
   }
  })
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