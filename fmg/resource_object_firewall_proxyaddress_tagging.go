// Copyright 2020 Fortinet, Inc. All rights reserved.
// Author: Hongbin Lu (@fgtdev-hblu), Frank Shen (@frankshen01)
// Documentation:
// Hongbin Lu (@fgtdev-hblu), Frank Shen (@frankshen01),
// Xing Li (@lix-fortinet), Yue Wang (@yuew-ftnt)

// Description: Config object tagging.

package fortimanager

import (
	"fmt"
	"log"
	"strconv"

	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/validation"
)

func resourceObjectFirewallProxyAddressTagging() *schema.Resource {
	return &schema.Resource{
		Create: resourceObjectFirewallProxyAddressTaggingCreate,
		Read:   resourceObjectFirewallProxyAddressTaggingRead,
		Update: resourceObjectFirewallProxyAddressTaggingUpdate,
		Delete: resourceObjectFirewallProxyAddressTaggingDelete,

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
			"proxy_address": &schema.Schema{
				Type:     schema.TypeString,
				Required: true,
				ForceNew: true,
			},
			"category": &schema.Schema{
				Type:     schema.TypeString,
				Optional: true,
			},
			"name": &schema.Schema{
				Type:     schema.TypeString,
				ForceNew: true,
				Optional: true,
			},
			"tags": &schema.Schema{
				Type:     schema.TypeSet,
				Elem:     &schema.Schema{Type: schema.TypeString},
				Optional: true,
				Computed: true,
			},
		},
	}
}

func resourceObjectFirewallProxyAddressTaggingCreate(d *schema.ResourceData, m interface{}) error {
	c := m.(*FortiClient).Client
	c.Retries = 1

	paradict := make(map[string]string)
	cfg := m.(*FortiClient).Cfg
	adomv, err := adomChecking(cfg, d)
	if err != nil {
		return fmt.Errorf("Error adom configuration: %v", err)
	}
	paradict["adom"] = adomv

	proxy_address := d.Get("proxy_address").(string)
	paradict["proxy_address"] = proxy_address

	obj, err := getObjectObjectFirewallProxyAddressTagging(d)
	if err != nil {
		return fmt.Errorf("Error creating ObjectFirewallProxyAddressTagging resource while getting object: %v", err)
	}

	_, err = c.CreateObjectFirewallProxyAddressTagging(obj, paradict)

	if err != nil {
		return fmt.Errorf("Error creating ObjectFirewallProxyAddressTagging resource: %v", err)
	}

	d.SetId(getStringKey(d, "name"))

	return resourceObjectFirewallProxyAddressTaggingRead(d, m)
}

func resourceObjectFirewallProxyAddressTaggingUpdate(d *schema.ResourceData, m interface{}) error {
	mkey := d.Id()
	c := m.(*FortiClient).Client
	c.Retries = 1

	paradict := make(map[string]string)
	cfg := m.(*FortiClient).Cfg
	adomv, err := adomChecking(cfg, d)
	if err != nil {
		return fmt.Errorf("Error adom configuration: %v", err)
	}
	paradict["adom"] = adomv

	proxy_address := d.Get("proxy_address").(string)
	paradict["proxy_address"] = proxy_address

	obj, err := getObjectObjectFirewallProxyAddressTagging(d)
	if err != nil {
		return fmt.Errorf("Error updating ObjectFirewallProxyAddressTagging resource while getting object: %v", err)
	}

	_, err = c.UpdateObjectFirewallProxyAddressTagging(obj, mkey, paradict)
	if err != nil {
		return fmt.Errorf("Error updating ObjectFirewallProxyAddressTagging resource: %v", err)
	}

	log.Printf(strconv.Itoa(c.Retries))

	d.SetId(getStringKey(d, "name"))

	return resourceObjectFirewallProxyAddressTaggingRead(d, m)
}

func resourceObjectFirewallProxyAddressTaggingDelete(d *schema.ResourceData, m interface{}) error {
	mkey := d.Id()

	c := m.(*FortiClient).Client
	c.Retries = 1

	paradict := make(map[string]string)
	cfg := m.(*FortiClient).Cfg
	adomv, err := adomChecking(cfg, d)
	if err != nil {
		return fmt.Errorf("Error adom configuration: %v", err)
	}
	paradict["adom"] = adomv

	proxy_address := d.Get("proxy_address").(string)
	paradict["proxy_address"] = proxy_address

	err = c.DeleteObjectFirewallProxyAddressTagging(mkey, paradict)
	if err != nil {
		return fmt.Errorf("Error deleting ObjectFirewallProxyAddressTagging resource: %v", err)
	}

	d.SetId("")

	return nil
}

func resourceObjectFirewallProxyAddressTaggingRead(d *schema.ResourceData, m interface{}) error {
	mkey := d.Id()

	c := m.(*FortiClient).Client
	c.Retries = 1

	paradict := make(map[string]string)
	cfg := m.(*FortiClient).Cfg
	adomv, err := adomChecking(cfg, d)
	if err != nil {
		return fmt.Errorf("Error adom configuration: %v", err)
	}
	paradict["adom"] = adomv

	proxy_address := d.Get("proxy_address").(string)
	if proxy_address == "" {
		proxy_address = importOptionChecking(m.(*FortiClient).Cfg, "proxy_address")
		if proxy_address == "" {
			return fmt.Errorf("Parameter proxy_address is missing")
		}
		if err = d.Set("proxy_address", proxy_address); err != nil {
			return fmt.Errorf("Error set params proxy_address: %v", err)
		}
	}
	paradict["proxy_address"] = proxy_address

	o, err := c.ReadObjectFirewallProxyAddressTagging(mkey, paradict)
	if err != nil {
		return fmt.Errorf("Error reading ObjectFirewallProxyAddressTagging resource: %v", err)
	}

	if o == nil {
		log.Printf("[WARN] resource (%s) not found, removing from state", d.Id())
		d.SetId("")
		return nil
	}

	err = refreshObjectObjectFirewallProxyAddressTagging(d, o)
	if err != nil {
		return fmt.Errorf("Error reading ObjectFirewallProxyAddressTagging resource from API: %v", err)
	}
	return nil
}

func flattenObjectFirewallProxyAddressTaggingCategory2edl(v interface{}, d *schema.ResourceData, pre string) interface{} {
	return v
}

func flattenObjectFirewallProxyAddressTaggingName2edl(v interface{}, d *schema.ResourceData, pre string) interface{} {
	return v
}

func flattenObjectFirewallProxyAddressTaggingTags2edl(v interface{}, d *schema.ResourceData, pre string) interface{} {
	return flattenStringList(v)
}

func refreshObjectObjectFirewallProxyAddressTagging(d *schema.ResourceData, o map[string]interface{}) error {
	var err error

	if stValue := d.Get("scopetype"); stValue == "" {
		d.Set("scopetype", "inherit")
	}

	if err = d.Set("category", flattenObjectFirewallProxyAddressTaggingCategory2edl(o["category"], d, "category")); err != nil {
		if vv, ok := fortiAPIPatch(o["category"], "ObjectFirewallProxyAddressTagging-Category"); ok {
			if err = d.Set("category", vv); err != nil {
				return fmt.Errorf("Error reading category: %v", err)
			}
		} else {
			return fmt.Errorf("Error reading category: %v", err)
		}
	}

	if err = d.Set("name", flattenObjectFirewallProxyAddressTaggingName2edl(o["name"], d, "name")); err != nil {
		if vv, ok := fortiAPIPatch(o["name"], "ObjectFirewallProxyAddressTagging-Name"); ok {
			if err = d.Set("name", vv); err != nil {
				return fmt.Errorf("Error reading name: %v", err)
			}
		} else {
			return fmt.Errorf("Error reading name: %v", err)
		}
	}

	if err = d.Set("tags", flattenObjectFirewallProxyAddressTaggingTags2edl(o["tags"], d, "tags")); err != nil {
		if vv, ok := fortiAPIPatch(o["tags"], "ObjectFirewallProxyAddressTagging-Tags"); ok {
			if err = d.Set("tags", vv); err != nil {
				return fmt.Errorf("Error reading tags: %v", err)
			}
		} else {
			return fmt.Errorf("Error reading tags: %v", err)
		}
	}

	return nil
}

func flattenObjectFirewallProxyAddressTaggingFortiTestDebug(d *schema.ResourceData, fosdebugsn int, fosdebugbeg int, fosdebugend int) {
	log.Printf(strconv.Itoa(fosdebugsn))
	e := validation.IntBetween(fosdebugbeg, fosdebugend)
	log.Printf("ER List: %v", e)
}

func expandObjectFirewallProxyAddressTaggingCategory2edl(d *schema.ResourceData, v interface{}, pre string) (interface{}, error) {
	return v, nil
}

func expandObjectFirewallProxyAddressTaggingName2edl(d *schema.ResourceData, v interface{}, pre string) (interface{}, error) {
	return v, nil
}

func expandObjectFirewallProxyAddressTaggingTags2edl(d *schema.ResourceData, v interface{}, pre string) (interface{}, error) {
	return expandStringList(v.(*schema.Set).List()), nil
}

func getObjectObjectFirewallProxyAddressTagging(d *schema.ResourceData) (*map[string]interface{}, error) {
	obj := make(map[string]interface{})

	if v, ok := d.GetOk("category"); ok || d.HasChange("category") {
		t, err := expandObjectFirewallProxyAddressTaggingCategory2edl(d, v, "category")
		if err != nil {
			return &obj, err
		} else if t != nil {
			obj["category"] = t
		}
	}

	if v, ok := d.GetOk("name"); ok || d.HasChange("name") {
		t, err := expandObjectFirewallProxyAddressTaggingName2edl(d, v, "name")
		if err != nil {
			return &obj, err
		} else if t != nil {
			obj["name"] = t
		}
	}

	if v, ok := d.GetOk("tags"); ok || d.HasChange("tags") {
		t, err := expandObjectFirewallProxyAddressTaggingTags2edl(d, v, "tags")
		if err != nil {
			return &obj, err
		} else if t != nil {
			obj["tags"] = t
		}
	}

	return &obj, nil
}
