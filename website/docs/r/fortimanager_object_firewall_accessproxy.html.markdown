---
subcategory: "Object Firewall"
layout: "fortimanager"
page_title: "FortiManager: fortimanager_object_firewall_accessproxy"
description: |-
  Configure Access Proxy.
---

# fortimanager_object_firewall_accessproxy
Configure Access Proxy.

## Argument Reference


The following arguments are supported:

* `scopetype` - The scope of application of the resource. Valid values: `inherit`, `adom`, `global`. The `inherit` means that the scopetype of the provider will be inherited, and adom will also be inherited. The default value is `inherit`.
* `adom` - Adom. This value is valid only when the `scopetype` is `adom`, otherwise the value of adom in the provider will be inherited.

* `add_vhost_domain_to_dnsdb` - Enable/disable adding vhost/domain to dnsdb for ztna dox tunnel. Valid values: `disable`, `enable`.

* `api_gateway` - Api-Gateway. The structure of `api_gateway` block is documented below.
* `api_gateway6` - Api-Gateway6. The structure of `api_gateway6` block is documented below.
* `auth_portal` - Enable/disable authentication portal. Valid values: `disable`, `enable`.

* `auth_virtual_host` - Virtual host for authentication portal.
* `client_cert` - Enable/disable to request client certificate. Valid values: `disable`, `enable`.

* `decrypted_traffic_mirror` - Decrypted traffic mirror.
* `empty_cert_action` - Action of an empty client certificate. Valid values: `block`, `accept`.

* `http_supported_max_version` - Maximum supported HTTP versions. default = HTTP2 Valid values: `http1`, `http2`.

* `ldb_method` - Method used to distribute sessions to SSL real servers. Valid values: `static`, `round-robin`, `weighted`, `least-session`, `least-rtt`, `first-alive`.

* `log_blocked_traffic` - Enable/disable logging of blocked traffic. Valid values: `disable`, `enable`.

* `name` - Access Proxy name.
* `svr_pool_multiplex` - Enable/disable server pool multiplexing. Share connected server in HTTP, HTTPS, and web-portal api-gateway. Valid values: `disable`, `enable`.

* `svr_pool_server_max_concurrent_request` - Maximum number of concurrent requests that servers in server pool could handle (default = unlimited).
* `svr_pool_server_max_request` - Maximum number of requests that servers in server pool handle before disconnecting (default = unlimited).
* `svr_pool_ttl` - Time-to-live in the server pool for idle connections to servers.
* `user_agent_detect` - Enable/disable to detect device type by HTTP user-agent if no client certificate provided. Valid values: `disable`, `enable`.

* `realservers` - Realservers. The structure of `realservers` block is documented below.
* `server_pubkey_auth` - Enable/disable SSH real server public key authentication. Valid values: `disable`, `enable`.

* `server_pubkey_auth_settings` - Server-Pubkey-Auth-Settings. The structure of `server_pubkey_auth_settings` block is documented below.
* `vip` - Virtual IP name.
* `dynamic_sort_subtable` - true or false, set this parameter to true when using dynamic for_each + toset to configure and sort sub-tables, please do not set this parameter when configuring static sub-tables.

The `api_gateway` block supports:

* `application` - SaaS application controlled by this Access Proxy.
* `h2_support` - HTTP2 support, default=Enable. Valid values: `disable`, `enable`.

* `h3_support` - HTTP3/QUIC support, default=Disable. Valid values: `disable`, `enable`.

* `http_cookie_age` - Time in minutes that client web browsers should keep a cookie. Default is 60 minutes. 0 = no time limit.
* `http_cookie_domain` - Domain that HTTP cookie persistence should apply to.
* `http_cookie_domain_from_host` - Enable/disable use of HTTP cookie domain from host field in HTTP. Valid values: `disable`, `enable`.

* `http_cookie_generation` - Generation of HTTP cookie to be accepted. Changing invalidates all existing cookies.
* `http_cookie_path` - Limit HTTP cookie persistence to the specified path.
* `http_cookie_share` - Control sharing of cookies across API Gateway. same-ip means a cookie from one virtual server can be used by another. Disable stops cookie sharing. Valid values: `disable`, `same-ip`.

* `https_cookie_secure` - Enable/disable verification that inserted HTTPS cookies are secure. Valid values: `disable`, `enable`.

* `id` - API Gateway ID.
* `ldb_method` - Method used to distribute sessions to real servers. Valid values: `static`, `round-robin`, `weighted`, `least-session`, `least-rtt`, `first-alive`, `http-host`.

* `persistence` - Configure how to make sure that clients connect to the same server every time they make a request that is part of the same session. Valid values: `none`, `http-cookie`.

* `quic` - Quic. The structure of `quic` block is documented below.
* `realservers` - Realservers. The structure of `realservers` block is documented below.
* `saml_redirect` - Enable/disable SAML redirection after successful authentication. Valid values: `disable`, `enable`.

* `saml_server` - SAML service provider configuration for VIP authentication.
* `service` - Service. Valid values: `http`, `https`, `tcp-forwarding`, `samlsp`.

* `ssl_algorithm` - Permitted encryption algorithms for the server side of SSL full mode sessions according to encryption strength. Valid values: `high`, `medium`, `low`, `custom`.

* `ssl_cipher_suites` - Ssl-Cipher-Suites. The structure of `ssl_cipher_suites` block is documented below.
* `ssl_dh_bits` - Number of bits to use in the Diffie-Hellman exchange for RSA encryption of SSL sessions. Valid values: `768`, `1024`, `1536`, `2048`, `3072`, `4096`.

* `ssl_max_version` - Highest SSL/TLS version acceptable from a server. Valid values: `tls-1.0`, `tls-1.1`, `tls-1.2`, `tls-1.3`.

* `ssl_min_version` - Lowest SSL/TLS version acceptable from a server. Valid values: `tls-1.0`, `tls-1.1`, `tls-1.2`, `tls-1.3`.

* `ssl_renegotiation` - Enable/disable secure renegotiation to comply with RFC 5746. Valid values: `disable`, `enable`.

* `ssl_vpn_web_portal` - SSL-VPN web portal.
* `url_map` - URL pattern to match.
* `url_map_type` - Type of url-map. Valid values: `sub-string`, `wildcard`, `regex`.

* `virtual_host` - Virtual host.

The `quic` block supports:

* `ack_delay_exponent` - ACK delay exponent (1 - 20, default = 3).
* `active_connection_id_limit` - Active connection ID limit (1 - 8, default = 2).
* `active_migration` - Enable/disable active migration (default = disable). Valid values: `disable`, `enable`.

* `grease_quic_bit` - Enable/disable grease QUIC bit (default = enable). Valid values: `disable`, `enable`.

* `max_ack_delay` - Maximum ACK delay in milliseconds (1 - 16383, default = 25).
* `max_datagram_frame_size` - Maximum datagram frame size in bytes (1 - 1500, default = 1500).
* `max_idle_timeout` - Maximum idle timeout milliseconds (1 - 60000, default = 30000).
* `max_udp_payload_size` - Maximum UDP payload size in bytes (1200 - 1500, default = 1500).

The `realservers` block supports:

* `addr_type` - Type of address. Valid values: `fqdn`, `ip`.

* `address` - Address or address group of the real server.
* `domain` - Wildcard domain name of the real server.
* `external_auth` - Enable/disable use of external browser as user-agent for SAML user authentication. Valid values: `disable`, `enable`.

* `health_check` - Enable to check the responsiveness of the real server before forwarding traffic. Valid values: `disable`, `enable`.

* `health_check_proto` - Protocol of the health check monitor to use when polling to determine server's connectivity status. Valid values: `ping`, `http`, `tcp-connect`.

* `holddown_interval` - Enable/disable holddown timer. Server will be considered active and reachable once the holddown period has expired (30 seconds). Valid values: `disable`, `enable`.

* `http_host` - HTTP server domain name in HTTP header.
* `id` - Real server ID.
* `ip` - IP address of the real server.
* `mappedport` - Port for communicating with the real server.
* `port` - Port for communicating with the real server.
* `ssh_client_cert` - Set access-proxy SSH client certificate profile.
* `ssh_host_key` - One or more server host key.
* `ssh_host_key_validation` - Enable/disable SSH real server host key validation. Valid values: `disable`, `enable`.

* `status` - Set the status of the real server to active so that it can accept traffic, or on standby or disabled so no traffic is sent. Valid values: `active`, `standby`, `disable`.

* `translate_host` - Enable/disable translation of hostname/IP from virtual server to real server. Valid values: `disable`, `enable`.

* `tunnel_encryption` - Tunnel encryption. Valid values: `disable`, `enable`.

* `type` - TCP forwarding server type. Valid values: `tcp-forwarding`, `ssh`.

* `weight` - Weight of the real server. If weighted load balancing is enabled, the server with the highest weight gets more connections.

The `ssl_cipher_suites` block supports:

* `cipher` - Cipher suite name. Valid values: `TLS-RSA-WITH-RC4-128-MD5`, `TLS-RSA-WITH-RC4-128-SHA`, `TLS-RSA-WITH-DES-CBC-SHA`, `TLS-RSA-WITH-3DES-EDE-CBC-SHA`, `TLS-RSA-WITH-AES-128-CBC-SHA`, `TLS-RSA-WITH-AES-256-CBC-SHA`, `TLS-RSA-WITH-AES-128-CBC-SHA256`, `TLS-RSA-WITH-AES-256-CBC-SHA256`, `TLS-RSA-WITH-CAMELLIA-128-CBC-SHA`, `TLS-RSA-WITH-CAMELLIA-256-CBC-SHA`, `TLS-RSA-WITH-CAMELLIA-128-CBC-SHA256`, `TLS-RSA-WITH-CAMELLIA-256-CBC-SHA256`, `TLS-RSA-WITH-SEED-CBC-SHA`, `TLS-RSA-WITH-ARIA-128-CBC-SHA256`, `TLS-RSA-WITH-ARIA-256-CBC-SHA384`, `TLS-DHE-RSA-WITH-DES-CBC-SHA`, `TLS-DHE-RSA-WITH-3DES-EDE-CBC-SHA`, `TLS-DHE-RSA-WITH-AES-128-CBC-SHA`, `TLS-DHE-RSA-WITH-AES-256-CBC-SHA`, `TLS-DHE-RSA-WITH-AES-128-CBC-SHA256`, `TLS-DHE-RSA-WITH-AES-256-CBC-SHA256`, `TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA`, `TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SHA`, `TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA256`, `TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SHA256`, `TLS-DHE-RSA-WITH-SEED-CBC-SHA`, `TLS-DHE-RSA-WITH-ARIA-128-CBC-SHA256`, `TLS-DHE-RSA-WITH-ARIA-256-CBC-SHA384`, `TLS-ECDHE-RSA-WITH-RC4-128-SHA`, `TLS-ECDHE-RSA-WITH-3DES-EDE-CBC-SHA`, `TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA`, `TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA`, `TLS-ECDHE-RSA-WITH-CHACHA20-POLY1305-SHA256`, `TLS-ECDHE-ECDSA-WITH-CHACHA20-POLY1305-SHA256`, `TLS-DHE-RSA-WITH-CHACHA20-POLY1305-SHA256`, `TLS-DHE-RSA-WITH-AES-128-GCM-SHA256`, `TLS-DHE-RSA-WITH-AES-256-GCM-SHA384`, `TLS-DHE-DSS-WITH-AES-128-CBC-SHA`, `TLS-DHE-DSS-WITH-AES-256-CBC-SHA`, `TLS-DHE-DSS-WITH-AES-128-CBC-SHA256`, `TLS-DHE-DSS-WITH-AES-128-GCM-SHA256`, `TLS-DHE-DSS-WITH-AES-256-CBC-SHA256`, `TLS-DHE-DSS-WITH-AES-256-GCM-SHA384`, `TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA256`, `TLS-ECDHE-RSA-WITH-AES-128-GCM-SHA256`, `TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA384`, `TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384`, `TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA`, `TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA256`, `TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256`, `TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA384`, `TLS-ECDHE-ECDSA-WITH-AES-256-GCM-SHA384`, `TLS-RSA-WITH-AES-128-GCM-SHA256`, `TLS-RSA-WITH-AES-256-GCM-SHA384`, `TLS-DHE-DSS-WITH-CAMELLIA-128-CBC-SHA`, `TLS-DHE-DSS-WITH-CAMELLIA-256-CBC-SHA`, `TLS-DHE-DSS-WITH-CAMELLIA-128-CBC-SHA256`, `TLS-DHE-DSS-WITH-CAMELLIA-256-CBC-SHA256`, `TLS-DHE-DSS-WITH-SEED-CBC-SHA`, `TLS-DHE-DSS-WITH-ARIA-128-CBC-SHA256`, `TLS-DHE-DSS-WITH-ARIA-256-CBC-SHA384`, `TLS-ECDHE-RSA-WITH-ARIA-128-CBC-SHA256`, `TLS-ECDHE-RSA-WITH-ARIA-256-CBC-SHA384`, `TLS-ECDHE-ECDSA-WITH-ARIA-128-CBC-SHA256`, `TLS-ECDHE-ECDSA-WITH-ARIA-256-CBC-SHA384`, `TLS-DHE-DSS-WITH-3DES-EDE-CBC-SHA`, `TLS-DHE-DSS-WITH-DES-CBC-SHA`, `TLS-AES-128-GCM-SHA256`, `TLS-AES-256-GCM-SHA384`, `TLS-CHACHA20-POLY1305-SHA256`.

* `priority` - SSL/TLS cipher suites priority.
* `versions` - SSL/TLS versions that the cipher suite can be used with. Valid values: `tls-1.0`, `tls-1.1`, `tls-1.2`, `tls-1.3`.


The `api_gateway6` block supports:

* `application` - SaaS application controlled by this Access Proxy.
* `h2_support` - HTTP2 support, default=Enable. Valid values: `disable`, `enable`.

* `h3_support` - HTTP3/QUIC support, default=Disable. Valid values: `disable`, `enable`.

* `http_cookie_age` - Time in minutes that client web browsers should keep a cookie. Default is 60 minutes. 0 = no time limit.
* `http_cookie_domain` - Domain that HTTP cookie persistence should apply to.
* `http_cookie_domain_from_host` - Enable/disable use of HTTP cookie domain from host field in HTTP. Valid values: `disable`, `enable`.

* `http_cookie_generation` - Generation of HTTP cookie to be accepted. Changing invalidates all existing cookies.
* `http_cookie_path` - Limit HTTP cookie persistence to the specified path.
* `http_cookie_share` - Control sharing of cookies across API Gateway. same-ip means a cookie from one virtual server can be used by another. Disable stops cookie sharing. Valid values: `disable`, `same-ip`.

* `https_cookie_secure` - Enable/disable verification that inserted HTTPS cookies are secure. Valid values: `disable`, `enable`.

* `id` - API Gateway ID.
* `ldb_method` - Method used to distribute sessions to real servers. Valid values: `static`, `round-robin`, `weighted`, `first-alive`, `http-host`.

* `persistence` - Configure how to make sure that clients connect to the same server every time they make a request that is part of the same session. Valid values: `none`, `http-cookie`.

* `quic` - Quic. The structure of `quic` block is documented below.
* `realservers` - Realservers. The structure of `realservers` block is documented below.
* `saml_redirect` - Enable/disable SAML redirection after successful authentication. Valid values: `disable`, `enable`.

* `saml_server` - SAML service provider configuration for VIP authentication.
* `service` - Service. Valid values: `http`, `https`, `tcp-forwarding`, `samlsp`.

* `ssl_algorithm` - Permitted encryption algorithms for the server side of SSL full mode sessions according to encryption strength. Valid values: `high`, `medium`, `low`.

* `ssl_cipher_suites` - Ssl-Cipher-Suites. The structure of `ssl_cipher_suites` block is documented below.
* `ssl_dh_bits` - Number of bits to use in the Diffie-Hellman exchange for RSA encryption of SSL sessions. Valid values: `768`, `1024`, `1536`, `2048`, `3072`, `4096`.

* `ssl_max_version` - Highest SSL/TLS version acceptable from a server. Valid values: `tls-1.0`, `tls-1.1`, `tls-1.2`, `tls-1.3`.

* `ssl_min_version` - Lowest SSL/TLS version acceptable from a server. Valid values: `tls-1.0`, `tls-1.1`, `tls-1.2`, `tls-1.3`.

* `ssl_renegotiation` - Enable/disable secure renegotiation to comply with RFC 5746. Valid values: `disable`, `enable`.

* `ssl_vpn_web_portal` - SSL-VPN web portal.
* `url_map` - URL pattern to match.
* `url_map_type` - Type of url-map. Valid values: `sub-string`, `wildcard`, `regex`.

* `virtual_host` - Virtual host.

The `quic` block supports:

* `ack_delay_exponent` - ACK delay exponent (1 - 20, default = 3).
* `active_connection_id_limit` - Active connection ID limit (1 - 8, default = 2).
* `active_migration` - Enable/disable active migration (default = disable). Valid values: `disable`, `enable`.

* `grease_quic_bit` - Enable/disable grease QUIC bit (default = enable). Valid values: `disable`, `enable`.

* `max_ack_delay` - Maximum ACK delay in milliseconds (1 - 16383, default = 25).
* `max_datagram_frame_size` - Maximum datagram frame size in bytes (1 - 1500, default = 1500).
* `max_idle_timeout` - Maximum idle timeout milliseconds (1 - 60000, default = 30000).
* `max_udp_payload_size` - Maximum UDP payload size in bytes (1200 - 1500, default = 1500).

The `realservers` block supports:

* `addr_type` - Type of address. Valid values: `fqdn`, `ip`.

* `address` - Address or address group of the real server.
* `domain` - Wildcard domain name of the real server.
* `external_auth` - Enable/disable use of external browser as user-agent for SAML user authentication. Valid values: `disable`, `enable`.

* `health_check` - Enable to check the responsiveness of the real server before forwarding traffic. Valid values: `disable`, `enable`.

* `health_check_proto` - Protocol of the health check monitor to use when polling to determine server's connectivity status. Valid values: `ping`, `http`, `tcp-connect`.

* `holddown_interval` - Enable/disable holddown timer. Server will be considered active and reachable once the holddown period has expired (30 seconds). Valid values: `disable`, `enable`.

* `http_host` - HTTP server domain name in HTTP header.
* `id` - Real server ID.
* `ip` - IPv6 address of the real server.
* `mappedport` - Port for communicating with the real server.
* `port` - Port for communicating with the real server.
* `ssh_client_cert` - Set access-proxy SSH client certificate profile.
* `ssh_host_key` - One or more server host key.
* `ssh_host_key_validation` - Enable/disable SSH real server host key validation. Valid values: `disable`, `enable`.

* `status` - Set the status of the real server to active so that it can accept traffic, or on standby or disabled so no traffic is sent. Valid values: `active`, `standby`, `disable`.

* `translate_host` - Enable/disable translation of hostname/IP from virtual server to real server. Valid values: `disable`, `enable`.

* `tunnel_encryption` - Tunnel encryption. Valid values: `disable`, `enable`.

* `type` - TCP forwarding server type. Valid values: `tcp-forwarding`, `ssh`.

* `weight` - Weight of the real server. If weighted load balancing is enabled, the server with the highest weight gets more connections.

The `ssl_cipher_suites` block supports:

* `cipher` - Cipher suite name. Valid values: `TLS-RSA-WITH-RC4-128-MD5`, `TLS-RSA-WITH-RC4-128-SHA`, `TLS-RSA-WITH-DES-CBC-SHA`, `TLS-RSA-WITH-3DES-EDE-CBC-SHA`, `TLS-RSA-WITH-AES-128-CBC-SHA`, `TLS-RSA-WITH-AES-256-CBC-SHA`, `TLS-RSA-WITH-AES-128-CBC-SHA256`, `TLS-RSA-WITH-AES-256-CBC-SHA256`, `TLS-RSA-WITH-CAMELLIA-128-CBC-SHA`, `TLS-RSA-WITH-CAMELLIA-256-CBC-SHA`, `TLS-RSA-WITH-CAMELLIA-128-CBC-SHA256`, `TLS-RSA-WITH-CAMELLIA-256-CBC-SHA256`, `TLS-RSA-WITH-SEED-CBC-SHA`, `TLS-RSA-WITH-ARIA-128-CBC-SHA256`, `TLS-RSA-WITH-ARIA-256-CBC-SHA384`, `TLS-DHE-RSA-WITH-DES-CBC-SHA`, `TLS-DHE-RSA-WITH-3DES-EDE-CBC-SHA`, `TLS-DHE-RSA-WITH-AES-128-CBC-SHA`, `TLS-DHE-RSA-WITH-AES-256-CBC-SHA`, `TLS-DHE-RSA-WITH-AES-128-CBC-SHA256`, `TLS-DHE-RSA-WITH-AES-256-CBC-SHA256`, `TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA`, `TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SHA`, `TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA256`, `TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SHA256`, `TLS-DHE-RSA-WITH-SEED-CBC-SHA`, `TLS-DHE-RSA-WITH-ARIA-128-CBC-SHA256`, `TLS-DHE-RSA-WITH-ARIA-256-CBC-SHA384`, `TLS-ECDHE-RSA-WITH-RC4-128-SHA`, `TLS-ECDHE-RSA-WITH-3DES-EDE-CBC-SHA`, `TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA`, `TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA`, `TLS-ECDHE-RSA-WITH-CHACHA20-POLY1305-SHA256`, `TLS-ECDHE-ECDSA-WITH-CHACHA20-POLY1305-SHA256`, `TLS-DHE-RSA-WITH-CHACHA20-POLY1305-SHA256`, `TLS-DHE-RSA-WITH-AES-128-GCM-SHA256`, `TLS-DHE-RSA-WITH-AES-256-GCM-SHA384`, `TLS-DHE-DSS-WITH-AES-128-CBC-SHA`, `TLS-DHE-DSS-WITH-AES-256-CBC-SHA`, `TLS-DHE-DSS-WITH-AES-128-CBC-SHA256`, `TLS-DHE-DSS-WITH-AES-128-GCM-SHA256`, `TLS-DHE-DSS-WITH-AES-256-CBC-SHA256`, `TLS-DHE-DSS-WITH-AES-256-GCM-SHA384`, `TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA256`, `TLS-ECDHE-RSA-WITH-AES-128-GCM-SHA256`, `TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA384`, `TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384`, `TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA`, `TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA256`, `TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256`, `TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA384`, `TLS-ECDHE-ECDSA-WITH-AES-256-GCM-SHA384`, `TLS-RSA-WITH-AES-128-GCM-SHA256`, `TLS-RSA-WITH-AES-256-GCM-SHA384`, `TLS-DHE-DSS-WITH-CAMELLIA-128-CBC-SHA`, `TLS-DHE-DSS-WITH-CAMELLIA-256-CBC-SHA`, `TLS-DHE-DSS-WITH-CAMELLIA-128-CBC-SHA256`, `TLS-DHE-DSS-WITH-CAMELLIA-256-CBC-SHA256`, `TLS-DHE-DSS-WITH-SEED-CBC-SHA`, `TLS-DHE-DSS-WITH-ARIA-128-CBC-SHA256`, `TLS-DHE-DSS-WITH-ARIA-256-CBC-SHA384`, `TLS-ECDHE-RSA-WITH-ARIA-128-CBC-SHA256`, `TLS-ECDHE-RSA-WITH-ARIA-256-CBC-SHA384`, `TLS-ECDHE-ECDSA-WITH-ARIA-128-CBC-SHA256`, `TLS-ECDHE-ECDSA-WITH-ARIA-256-CBC-SHA384`, `TLS-DHE-DSS-WITH-3DES-EDE-CBC-SHA`, `TLS-DHE-DSS-WITH-DES-CBC-SHA`, `TLS-AES-128-GCM-SHA256`, `TLS-AES-256-GCM-SHA384`, `TLS-CHACHA20-POLY1305-SHA256`, `TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA`.

* `priority` - SSL/TLS cipher suites priority.
* `versions` - SSL/TLS versions that the cipher suite can be used with. Valid values: `tls-1.0`, `tls-1.1`, `tls-1.2`, `tls-1.3`.


The `realservers` block supports:

* `id` - Real server ID.
* `ip` - IP address of the real server.
* `port` - Port for communicating with the real server.
* `status` - Set the status of the real server to active so that it can accept traffic, or on standby or disabled so no traffic is sent. Valid values: `active`, `standby`, `disable`.

* `weight` - Weight of the real server. If weighted load balancing is enabled, the server with the highest weight gets more connections.

The `server_pubkey_auth_settings` block supports:

* `auth_ca` - Name of the SSH server public key authentication CA.
* `cert_extension` - Cert-Extension. The structure of `cert_extension` block is documented below.
* `permit_agent_forwarding` - Enable/disable appending permit-agent-forwarding certificate extension. Valid values: `disable`, `enable`.

* `permit_port_forwarding` - Enable/disable appending permit-port-forwarding certificate extension. Valid values: `disable`, `enable`.

* `permit_pty` - Enable/disable appending permit-pty certificate extension. Valid values: `disable`, `enable`.

* `permit_user_rc` - Enable/disable appending permit-user-rc certificate extension. Valid values: `disable`, `enable`.

* `permit_x11_forwarding` - Enable/disable appending permit-x11-forwarding certificate extension. Valid values: `disable`, `enable`.

* `source_address` - Enable/disable appending source-address certificate critical option. This option ensure certificate only accepted from FortiGate source address. Valid values: `disable`, `enable`.


The `cert_extension` block supports:

* `critical` - Critical option. Valid values: `no`, `yes`.

* `data` - Name of certificate extension.
* `name` - Name of certificate extension.
* `type` - Type of certificate extension. Valid values: `fixed`, `user`.



## Attribute Reference

In addition to all the above arguments, the following attributes are exported:
* `id` - an identifier for the resource with format {{name}}.

## Import

ObjectFirewall AccessProxy can be imported using any of these accepted formats:
```

$ export "FORTIMANAGER_IMPORT_TABLE"="true"
$ terraform import fortimanager_object_firewall_accessproxy.labelname {{name}}
$ unset "FORTIMANAGER_IMPORT_TABLE"
```
-> **Hint:** The scopetype and adom for import will directly inherit the scopetype and adom configuration of the provider.
