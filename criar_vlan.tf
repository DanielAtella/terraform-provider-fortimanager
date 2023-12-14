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