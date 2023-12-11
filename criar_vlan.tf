terraform {
  required_providers {
    fortimanager = {
      source = "fortinetdev/fortimanager"
      version = "1.9.0"
    }
  }
}

provider "fortimanager" {
  hostname     = "10.150.218.70"
  username     = "rest_admin"
  password     = "F0rtil4b123!"
  insecure     = "true"
  scopetype    = "adom"
  adom         = "root"
}

resource "fortimanager_exec_workspace_action" "lockres" {
  action         = "lockbegin"
  scopetype      = "adom"
  adom           = "vFW"
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
            "url": "/pm/config/device/FGT2-N2/global/system/interface",
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


resource "fortimanager_exec_workspace_action" "unlockres" {
  action         = "commit"
  scopetype      = "adom"
  adom           = "vFW"
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
  depends_on     = [fortimanager_json_generic_api.Create_Vlan_100]
}






resource "fortimanager_exec_workspace_action" "unlockres" {
  action         = "lockend"
  scopetype      = "adom"
  adom           = "vFW"
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
  depends_on     = [fortimanager_json_generic_api.Create_Vlan_100]
}