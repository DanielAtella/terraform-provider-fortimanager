// Copyright 2020 Fortinet, Inc. All rights reserved.
// Author: Hongbin Lu (@fgtdev-hblu), Frank Shen (@frankshen01)
// Documentation:
// Hongbin Lu (@fgtdev-hblu), Frank Shen (@frankshen01),
// Xing Li (@lix-fortinet), Yue Wang (@yuew-ftnt)

// Description: Define known domain controller servers.

package fortimanager

import (
	"fmt"
	"log"
	"strconv"

	"github.com/hashicorp/terraform-plugin-sdk/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/helper/validation"
)

func resourceObjectCifsDomainController() *schema.Resource {
	return &schema.Resource{
		Create: resourceObjectCifsDomainControllerCreate,
		Read:   resourceObjectCifsDomainControllerRead,
		Update: resourceObjectCifsDomainControllerUpdate,
		Delete: resourceObjectCifsDomainControllerDelete,

		Importer: &schema.ResourceImporter{
			State: schema.ImportStatePassthrough,
		},

		Schema: map[string]*schema.Schema{
			"scopetype": &schema.Schema{
				Type:     schema.TypeString,
				Optional: true,
				Default:  "inherit",
				ForceNew: true,
				ValidateFunc: validation.StringInSlice([]string{
					"adom",
					"global",
					"inherit",
				}, false),
			},
			"adom": &schema.Schema{
				Type:     schema.TypeString,
				Optional: true,
				ForceNew: true,
			},
			"domain_name": &schema.Schema{
				Type:     schema.TypeString,
				Optional: true,
				Computed: true,
			},
			"ip": &schema.Schema{
				Type:     schema.TypeString,
				Optional: true,
				Computed: true,
			},
			"ip6": &schema.Schema{
				Type:     schema.TypeString,
				Optional: true,
				Computed: true,
			},
			"password": &schema.Schema{
				Type:     schema.TypeSet,
				Elem:     &schema.Schema{Type: schema.TypeString},
				Optional: true,
				Computed: true,
			},
			"port": &schema.Schema{
				Type:     schema.TypeInt,
				Optional: true,
				Computed: true,
			},
			"server_name": &schema.Schema{
				Type:     schema.TypeString,
				ForceNew: true,
				Optional: true,
				Computed: true,
			},
			"username": &schema.Schema{
				Type:     schema.TypeString,
				Optional: true,
				Computed: true,
			},
		},
	}
}

func resourceObjectCifsDomainControllerCreate(d *schema.ResourceData, m interface{}) error {
	c := m.(*FortiClient).Client
	c.Retries = 1

	cfg := m.(*FortiClient).Cfg
	adomv, err := adomChecking(cfg, d)
	if err != nil {
		return fmt.Errorf("Error adom configuration: %v", err)
	}

	obj, err := getObjectObjectCifsDomainController(d)
	if err != nil {
		return fmt.Errorf("Error creating ObjectCifsDomainController resource while getting object: %v", err)
	}

	_, err = c.CreateObjectCifsDomainController(obj, adomv, nil)

	if err != nil {
		return fmt.Errorf("Error creating ObjectCifsDomainController resource: %v", err)
	}

	d.SetId(getStringKey(d, "server_name"))

	return resourceObjectCifsDomainControllerRead(d, m)
}

func resourceObjectCifsDomainControllerUpdate(d *schema.ResourceData, m interface{}) error {
	mkey := d.Id()
	c := m.(*FortiClient).Client
	c.Retries = 1

	cfg := m.(*FortiClient).Cfg
	adomv, err := adomChecking(cfg, d)
	if err != nil {
		return fmt.Errorf("Error adom configuration: %v", err)
	}

	obj, err := getObjectObjectCifsDomainController(d)
	if err != nil {
		return fmt.Errorf("Error updating ObjectCifsDomainController resource while getting object: %v", err)
	}

	_, err = c.UpdateObjectCifsDomainController(obj, adomv, mkey, nil)
	if err != nil {
		return fmt.Errorf("Error updating ObjectCifsDomainController resource: %v", err)
	}

	log.Printf(strconv.Itoa(c.Retries))

	d.SetId(getStringKey(d, "server_name"))

	return resourceObjectCifsDomainControllerRead(d, m)
}

func resourceObjectCifsDomainControllerDelete(d *schema.ResourceData, m interface{}) error {
	mkey := d.Id()

	c := m.(*FortiClient).Client
	c.Retries = 1

	cfg := m.(*FortiClient).Cfg
	adomv, err := adomChecking(cfg, d)
	if err != nil {
		return fmt.Errorf("Error adom configuration: %v", err)
	}

	err = c.DeleteObjectCifsDomainController(adomv, mkey, nil)
	if err != nil {
		return fmt.Errorf("Error deleting ObjectCifsDomainController resource: %v", err)
	}

	d.SetId("")

	return nil
}

func resourceObjectCifsDomainControllerRead(d *schema.ResourceData, m interface{}) error {
	mkey := d.Id()

	c := m.(*FortiClient).Client
	c.Retries = 1

	cfg := m.(*FortiClient).Cfg
	adomv, err := adomChecking(cfg, d)
	if err != nil {
		return fmt.Errorf("Error adom configuration: %v", err)
	}

	o, err := c.ReadObjectCifsDomainController(adomv, mkey, nil)
	if err != nil {
		return fmt.Errorf("Error reading ObjectCifsDomainController resource: %v", err)
	}

	if o == nil {
		log.Printf("[WARN] resource (%s) not found, removing from state", d.Id())
		d.SetId("")
		return nil
	}

	err = refreshObjectObjectCifsDomainController(d, o)
	if err != nil {
		return fmt.Errorf("Error reading ObjectCifsDomainController resource from API: %v", err)
	}
	return nil
}

func flattenObjectCifsDomainControllerDomainName(v interface{}, d *schema.ResourceData, pre string) interface{} {
	return v
}

func flattenObjectCifsDomainControllerIp(v interface{}, d *schema.ResourceData, pre string) interface{} {
	return v
}

func flattenObjectCifsDomainControllerIp6(v interface{}, d *schema.ResourceData, pre string) interface{} {
	return v
}

func flattenObjectCifsDomainControllerPassword(v interface{}, d *schema.ResourceData, pre string) interface{} {
	return flattenStringList(v)
}

func flattenObjectCifsDomainControllerPort(v interface{}, d *schema.ResourceData, pre string) interface{} {
	return v
}

func flattenObjectCifsDomainControllerServerName(v interface{}, d *schema.ResourceData, pre string) interface{} {
	return v
}

func flattenObjectCifsDomainControllerUsername(v interface{}, d *schema.ResourceData, pre string) interface{} {
	return v
}

func refreshObjectObjectCifsDomainController(d *schema.ResourceData, o map[string]interface{}) error {
	var err error

	if stValue := d.Get("scopetype"); stValue == "" {
		d.Set("scopetype", "inherit")
	}

	if err = d.Set("domain_name", flattenObjectCifsDomainControllerDomainName(o["domain-name"], d, "domain_name")); err != nil {
		if vv, ok := fortiAPIPatch(o["domain-name"], "ObjectCifsDomainController-DomainName"); ok {
			if err = d.Set("domain_name", vv); err != nil {
				return fmt.Errorf("Error reading domain_name: %v", err)
			}
		} else {
			return fmt.Errorf("Error reading domain_name: %v", err)
		}
	}

	if err = d.Set("ip", flattenObjectCifsDomainControllerIp(o["ip"], d, "ip")); err != nil {
		if vv, ok := fortiAPIPatch(o["ip"], "ObjectCifsDomainController-Ip"); ok {
			if err = d.Set("ip", vv); err != nil {
				return fmt.Errorf("Error reading ip: %v", err)
			}
		} else {
			return fmt.Errorf("Error reading ip: %v", err)
		}
	}

	if err = d.Set("ip6", flattenObjectCifsDomainControllerIp6(o["ip6"], d, "ip6")); err != nil {
		if vv, ok := fortiAPIPatch(o["ip6"], "ObjectCifsDomainController-Ip6"); ok {
			if err = d.Set("ip6", vv); err != nil {
				return fmt.Errorf("Error reading ip6: %v", err)
			}
		} else {
			return fmt.Errorf("Error reading ip6: %v", err)
		}
	}

	if err = d.Set("password", flattenObjectCifsDomainControllerPassword(o["password"], d, "password")); err != nil {
		if vv, ok := fortiAPIPatch(o["password"], "ObjectCifsDomainController-Password"); ok {
			if err = d.Set("password", vv); err != nil {
				return fmt.Errorf("Error reading password: %v", err)
			}
		} else {
			return fmt.Errorf("Error reading password: %v", err)
		}
	}

	if err = d.Set("port", flattenObjectCifsDomainControllerPort(o["port"], d, "port")); err != nil {
		if vv, ok := fortiAPIPatch(o["port"], "ObjectCifsDomainController-Port"); ok {
			if err = d.Set("port", vv); err != nil {
				return fmt.Errorf("Error reading port: %v", err)
			}
		} else {
			return fmt.Errorf("Error reading port: %v", err)
		}
	}

	if err = d.Set("server_name", flattenObjectCifsDomainControllerServerName(o["server-name"], d, "server_name")); err != nil {
		if vv, ok := fortiAPIPatch(o["server-name"], "ObjectCifsDomainController-ServerName"); ok {
			if err = d.Set("server_name", vv); err != nil {
				return fmt.Errorf("Error reading server_name: %v", err)
			}
		} else {
			return fmt.Errorf("Error reading server_name: %v", err)
		}
	}

	if err = d.Set("username", flattenObjectCifsDomainControllerUsername(o["username"], d, "username")); err != nil {
		if vv, ok := fortiAPIPatch(o["username"], "ObjectCifsDomainController-Username"); ok {
			if err = d.Set("username", vv); err != nil {
				return fmt.Errorf("Error reading username: %v", err)
			}
		} else {
			return fmt.Errorf("Error reading username: %v", err)
		}
	}

	return nil
}

func flattenObjectCifsDomainControllerFortiTestDebug(d *schema.ResourceData, fosdebugsn int, fosdebugbeg int, fosdebugend int) {
	log.Printf(strconv.Itoa(fosdebugsn))
	e := validation.IntBetween(fosdebugbeg, fosdebugend)
	log.Printf("ER List: %v", e)
}

func expandObjectCifsDomainControllerDomainName(d *schema.ResourceData, v interface{}, pre string) (interface{}, error) {
	return v, nil
}

func expandObjectCifsDomainControllerIp(d *schema.ResourceData, v interface{}, pre string) (interface{}, error) {
	return v, nil
}

func expandObjectCifsDomainControllerIp6(d *schema.ResourceData, v interface{}, pre string) (interface{}, error) {
	return v, nil
}

func expandObjectCifsDomainControllerPassword(d *schema.ResourceData, v interface{}, pre string) (interface{}, error) {
	return expandStringList(v.(*schema.Set).List()), nil
}

func expandObjectCifsDomainControllerPort(d *schema.ResourceData, v interface{}, pre string) (interface{}, error) {
	return v, nil
}

func expandObjectCifsDomainControllerServerName(d *schema.ResourceData, v interface{}, pre string) (interface{}, error) {
	return v, nil
}

func expandObjectCifsDomainControllerUsername(d *schema.ResourceData, v interface{}, pre string) (interface{}, error) {
	return v, nil
}

func getObjectObjectCifsDomainController(d *schema.ResourceData) (*map[string]interface{}, error) {
	obj := make(map[string]interface{})

	if v, ok := d.GetOk("domain_name"); ok {
		t, err := expandObjectCifsDomainControllerDomainName(d, v, "domain_name")
		if err != nil {
			return &obj, err
		} else if t != nil {
			obj["domain-name"] = t
		}
	}

	if v, ok := d.GetOk("ip"); ok {
		t, err := expandObjectCifsDomainControllerIp(d, v, "ip")
		if err != nil {
			return &obj, err
		} else if t != nil {
			obj["ip"] = t
		}
	}

	if v, ok := d.GetOk("ip6"); ok {
		t, err := expandObjectCifsDomainControllerIp6(d, v, "ip6")
		if err != nil {
			return &obj, err
		} else if t != nil {
			obj["ip6"] = t
		}
	}

	if v, ok := d.GetOk("password"); ok {
		t, err := expandObjectCifsDomainControllerPassword(d, v, "password")
		if err != nil {
			return &obj, err
		} else if t != nil {
			obj["password"] = t
		}
	}

	if v, ok := d.GetOk("port"); ok {
		t, err := expandObjectCifsDomainControllerPort(d, v, "port")
		if err != nil {
			return &obj, err
		} else if t != nil {
			obj["port"] = t
		}
	}

	if v, ok := d.GetOk("server_name"); ok {
		t, err := expandObjectCifsDomainControllerServerName(d, v, "server_name")
		if err != nil {
			return &obj, err
		} else if t != nil {
			obj["server-name"] = t
		}
	}

	if v, ok := d.GetOk("username"); ok {
		t, err := expandObjectCifsDomainControllerUsername(d, v, "username")
		if err != nil {
			return &obj, err
		} else if t != nil {
			obj["username"] = t
		}
	}

	return &obj, nil
}
