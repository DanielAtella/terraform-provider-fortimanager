DC = {
  PSA = {
    dmz = {
      0 ={
        vlanid = 100
        interface = "port2"
        ifname = "VL100"
        address = "192.168.10.1/24"
    }
      1 ={
        vlanid = 200
        interface = "port2"
        ifname = "VL200"
        address = "192.168.11.1/24"
    }
   }
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