resource "aws_bgp_peer" "peer" {
  for_each = var.neighbors
  peer_id    = each.value
  customer_asn = var.customer_asn
  address_family = var.address_family
  authentication_key = var.authentication_key
}

resource "aws_bgp_route_table" "route_table" {
  for_each = var.vlans
  route {
    ipv4_prefix = each.value
  }
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