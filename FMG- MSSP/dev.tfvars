customer = {
  DummyCustumer = {
    interfaces = {
      VL_100 ={
        vlanid = 100
        interface = "port2"
        ifname = "VL100"
        address = "192.168.10.1/24"
        zone = "LAN"
    }
      VL_200 ={
        vlanid = 200
        interface = "port2"
        ifname = "VL200"
        address = "192.168.11.1/24"
        zone = "LAN"
    }
   }
    router_bgp = {
      DummyBgp = {
        customer_asn = 64200
        address_family = "IPv4"
        authentication_key = "qazwsx123!"
        nat_address = "192.168.40.0/24"
          neighbors = {
            192.168.12.12 {
              neighbor_address = "192.168.12.12"
              neighbor_asn = 2860
              authentication_key = "qazwsx123!"
            }
          }
      }
    }
    vdom = "DummyVdom"
    adom = "DummyAdom"
  }
}