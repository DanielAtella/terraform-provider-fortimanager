resource "fortimanager_exec_workspace_action" "lockres" {
  action         = "lockbegin"
  scopetype      = "adom"
  adom           = var.adom
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
}

resource "fortimanager_json_generic_api" "Delete_Vlan_100" {
  count = var.new_deploy == false ? 1 : 0
  json_content = <<JSON
  {
      "method": "delete",
      "params": [
          {
            "url": "/pm/config/device/FGT2-N1/global/system/interface",
              "data": {
                "name": "VL_100",
                "vdom": [
                    "FG-traffic"
                ],
                "mode": "static",
                "ip": [
                    "10.10.10.10",
                    "255.255.255.0"
                ],
                "allowaccess": "ping",
                "type": "vlan",
                "vlanid": 100,
                "vlan-protocol": "8021q",
                "interface": [
                    "LAG"
                ]
            }
          }
      ]
  }
  JSON
  }

resource "fortimanager_json_generic_api" "Create_Vlan_100" {
  count = var.new_deploy == true ? 1 : 0
  json_content = <<JSON
  {
      "method": "add",
      "params": [
          {
            "url": "/pm/config/device/FGT2-N1/global/system/interface",
              "data": {
                "name": "VL_100",
                "vdom": [
                    "FG-traffic"
                ],
                "mode": "static",
                "ip": [
                    "10.10.10.10",
                    "255.255.255.0"
                ],
                "allowaccess": "ping",
                "type": "vlan",
                "vlanid": 100,
                "vlan-protocol": "8021q",
                "interface": [
                    "LAG"
                ]
            }
          }
      ]
  }
  JSON
  }

resource "fortimanager_json_generic_api" "Commit_adom" {
    json_content = <<JSON
  {
      "method": "exec",
      "params": [
          {
            "url": "/dvmdb/adom/var.adom/workspace/commit"
          }
      ]
  }
  JSON
  }

resource "fortimanager_exec_workspace_action" "unlockres" {
  action         = "lockend"
  scopetype      = "adom"
  adom           = var.adom
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
  depends_on     = [fortimanager_json_generic_api.Commit_adom]
}