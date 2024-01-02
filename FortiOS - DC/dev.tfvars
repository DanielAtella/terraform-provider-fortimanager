DC = {
  PSA = {
    dmz0_vlanid = 100
    dmz0_intf = "port2"
    dmz0_ifname = "VL100"
    dmz0_address = "192.168.10.1/24"
    dmz1_vlanid = 200
    dmz1_intf = "port2"
    dmz1_ifname = "VL200"
    dmz1_address = "192.168.11.1/24"
    vdom = "root"
    zone = "DummyZone"
}
}

FW = {
  PSA = {
  policy_name = "Pol_Test1"
  policy_action = "accept"
  srcintf = "port1"
  dstintf = "DummyZone"
  service = "HTTP"
  }
}