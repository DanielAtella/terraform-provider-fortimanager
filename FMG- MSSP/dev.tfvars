customer = {
  DummyCustumer = {
    interfaces = {
      FGT8-NET1 ={
        vlanid = 229
        interface = "LAG"
        ifname = "FGT8-NET1"
        address = "192.168.12.237/31"
        zone = "FGT8_NET"
        type = "vlan"
    }
      FGT8-VPN1 ={
        vlanid = 230
        interface = "LAG"
        ifname = "FGT8-VPN1"
        address = "192.168.12.233/31"
        zone = "FGT8_VPN"
        type = "vlan"
    }
      FGT8-NET2 ={
        vlanid = 231
        interface = "LAG"
        ifname = "FGT8-NET2"
        address = "192.168.12.239/31"
        zone = "FGT8_NET"
        type = "vlan"
    }
      FGT8-VPN2 ={
        vlanid = 232
        interface = "LAG"
        ifname = "FGT8-VPN2"
        address = "192.168.12.235/31"
        zone = "FGT8_VPN"
        type = "vlan"
    }
      Loopback1 ={
        ifname = "Loopback1"
        address = "192.168.12.248/32"
        type = "loopback"
    }
   }
    router = {
      bgp = {
        customer_asn = 65022
        routerid = "192.168.12.229"
          neighbors = {
            0 = {
              neighbor_address = "192.168.12.236"
              neighbor_asn = 2860
              authentication_key = "qazwsx123!"
              address_family = "IPv4"
            }
          }
          community_list = {
            0 = {
              comm_list_name = "VRF-COMM-LIST"
              comm_list_action = "permit"
              comm_list_match = "2860:1"
            }
            1 = {
              comm_list_name = "INET-COMM-LIST"
              comm_list_action = "permit"
              comm_list_match = "2860:2"
            }
          }
          prefix_list = {
            0 = {
              prefix_list_name = "PL-PUBLIC-NETWORKS"
              prefix_list_address = "192.168.12.248/29"
            }
            1 = {
              prefix_list_name = "PL-ONLY-DEFAULT"
              prefix_list_address = "0.0.0.0/0"
            }
          }
          route_map = {
            "RM-VRF-MAIN-DC-IN" = {
              rm_name = "RM-VRF-MAIN-DC-IN"
              rule = {
                0 = {
                rm_set_comm = "2860:1"
                }
              }
            }
            "RM-VRF-MAIN-DC-OUT" = {
              rm_name = "RM-VRF-MAIN-DC-OUT"
              rule = { 
                0 = {
                rm_match_comm = "VRF-COMM-LIST"
                rm_action = "deny"
                }
                1 = {
                  rm_set_comm = "2860:12"
                }
                }
            }
            "RM-INET-MAIN-DC-IN" = {
              rm_name = "RM-INET-MAIN-DC-IN"
              rule = {
                0 = {
                rm_match_comm = "VRF-COMM-LIST"
                rm_match_address = "PL-ONLY-DEFAULT"
                rm_set_comm = "2860:2"
              }
              }
            }
            "RM-INET-MAIN-DC-OUT" = {
              rm_name = "RM-INET-MAIN-DC-OUT"
              rule = {
                0 = {
                rm_match_comm = "INET-COMM-LIST"
                rm_action = "deny"
              }
              1 = {
                rm_match_address = "PL-PUBLIC-NETWORKS"
                rm_set_comm = "2860:16"
              }
              }
            }
          }
          redistribute = {
        }
      }
    }
    firewall = {
      FGT8__FG-traffic = {
        ip_pool = {
        }
        object_address = {
        }
      }
    }
    vdom = "FG-Traffic"
    adom = "DummyAdom"
    hostname = "FGT8"
  }
}