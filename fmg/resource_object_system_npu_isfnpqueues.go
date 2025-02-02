// Copyright 2020 Fortinet, Inc. All rights reserved.
// Author: Hongbin Lu (@fgtdev-hblu), Frank Shen (@frankshen01)
// Documentation:
// Hongbin Lu (@fgtdev-hblu), Frank Shen (@frankshen01),
// Xing Li (@lix-fortinet), Yue Wang (@yuew-ftnt)

// Description: Configure queues of switch port connected to NP6 XAUI on ingress path.

package fortimanager

import (
	"fmt"
	"log"
	"strconv"

	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/validation"
)

func resourceObjectSystemNpuIsfNpQueues() *schema.Resource {
	return &schema.Resource{
		Create: resourceObjectSystemNpuIsfNpQueuesUpdate,
		Read:   resourceObjectSystemNpuIsfNpQueuesRead,
		Update: resourceObjectSystemNpuIsfNpQueuesUpdate,
		Delete: resourceObjectSystemNpuIsfNpQueuesDelete,

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
			"cos0": &schema.Schema{
				Type:     schema.TypeString,
				Optional: true,
			},
			"cos1": &schema.Schema{
				Type:     schema.TypeString,
				Optional: true,
			},
			"cos2": &schema.Schema{
				Type:     schema.TypeString,
				Optional: true,
			},
			"cos3": &schema.Schema{
				Type:     schema.TypeString,
				Optional: true,
			},
			"cos4": &schema.Schema{
				Type:     schema.TypeString,
				Optional: true,
			},
			"cos5": &schema.Schema{
				Type:     schema.TypeString,
				Optional: true,
			},
			"cos6": &schema.Schema{
				Type:     schema.TypeString,
				Optional: true,
			},
			"cos7": &schema.Schema{
				Type:     schema.TypeString,
				Optional: true,
			},
		},
	}
}

func resourceObjectSystemNpuIsfNpQueuesUpdate(d *schema.ResourceData, m interface{}) error {
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

	obj, err := getObjectObjectSystemNpuIsfNpQueues(d)
	if err != nil {
		return fmt.Errorf("Error updating ObjectSystemNpuIsfNpQueues resource while getting object: %v", err)
	}

	_, err = c.UpdateObjectSystemNpuIsfNpQueues(obj, mkey, paradict)
	if err != nil {
		return fmt.Errorf("Error updating ObjectSystemNpuIsfNpQueues resource: %v", err)
	}

	log.Printf(strconv.Itoa(c.Retries))

	d.SetId("ObjectSystemNpuIsfNpQueues")

	return resourceObjectSystemNpuIsfNpQueuesRead(d, m)
}

func resourceObjectSystemNpuIsfNpQueuesDelete(d *schema.ResourceData, m interface{}) error {
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

	err = c.DeleteObjectSystemNpuIsfNpQueues(mkey, paradict)
	if err != nil {
		return fmt.Errorf("Error deleting ObjectSystemNpuIsfNpQueues resource: %v", err)
	}

	d.SetId("")

	return nil
}

func resourceObjectSystemNpuIsfNpQueuesRead(d *schema.ResourceData, m interface{}) error {
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

	o, err := c.ReadObjectSystemNpuIsfNpQueues(mkey, paradict)
	if err != nil {
		return fmt.Errorf("Error reading ObjectSystemNpuIsfNpQueues resource: %v", err)
	}

	if o == nil {
		log.Printf("[WARN] resource (%s) not found, removing from state", d.Id())
		d.SetId("")
		return nil
	}

	err = refreshObjectObjectSystemNpuIsfNpQueues(d, o)
	if err != nil {
		return fmt.Errorf("Error reading ObjectSystemNpuIsfNpQueues resource from API: %v", err)
	}
	return nil
}

func flattenObjectSystemNpuIsfNpQueuesCos0(v interface{}, d *schema.ResourceData, pre string) interface{} {
	return conv2str(v)
}

func flattenObjectSystemNpuIsfNpQueuesCos1(v interface{}, d *schema.ResourceData, pre string) interface{} {
	return conv2str(v)
}

func flattenObjectSystemNpuIsfNpQueuesCos2(v interface{}, d *schema.ResourceData, pre string) interface{} {
	return conv2str(v)
}

func flattenObjectSystemNpuIsfNpQueuesCos3(v interface{}, d *schema.ResourceData, pre string) interface{} {
	return conv2str(v)
}

func flattenObjectSystemNpuIsfNpQueuesCos4(v interface{}, d *schema.ResourceData, pre string) interface{} {
	return conv2str(v)
}

func flattenObjectSystemNpuIsfNpQueuesCos5(v interface{}, d *schema.ResourceData, pre string) interface{} {
	return conv2str(v)
}

func flattenObjectSystemNpuIsfNpQueuesCos6(v interface{}, d *schema.ResourceData, pre string) interface{} {
	return conv2str(v)
}

func flattenObjectSystemNpuIsfNpQueuesCos7(v interface{}, d *schema.ResourceData, pre string) interface{} {
	return conv2str(v)
}

func refreshObjectObjectSystemNpuIsfNpQueues(d *schema.ResourceData, o map[string]interface{}) error {
	var err error

	if stValue := d.Get("scopetype"); stValue == "" {
		d.Set("scopetype", "inherit")
	}

	if err = d.Set("cos0", flattenObjectSystemNpuIsfNpQueuesCos0(o["cos0"], d, "cos0")); err != nil {
		if vv, ok := fortiAPIPatch(o["cos0"], "ObjectSystemNpuIsfNpQueues-Cos0"); ok {
			if err = d.Set("cos0", vv); err != nil {
				return fmt.Errorf("Error reading cos0: %v", err)
			}
		} else {
			return fmt.Errorf("Error reading cos0: %v", err)
		}
	}

	if err = d.Set("cos1", flattenObjectSystemNpuIsfNpQueuesCos1(o["cos1"], d, "cos1")); err != nil {
		if vv, ok := fortiAPIPatch(o["cos1"], "ObjectSystemNpuIsfNpQueues-Cos1"); ok {
			if err = d.Set("cos1", vv); err != nil {
				return fmt.Errorf("Error reading cos1: %v", err)
			}
		} else {
			return fmt.Errorf("Error reading cos1: %v", err)
		}
	}

	if err = d.Set("cos2", flattenObjectSystemNpuIsfNpQueuesCos2(o["cos2"], d, "cos2")); err != nil {
		if vv, ok := fortiAPIPatch(o["cos2"], "ObjectSystemNpuIsfNpQueues-Cos2"); ok {
			if err = d.Set("cos2", vv); err != nil {
				return fmt.Errorf("Error reading cos2: %v", err)
			}
		} else {
			return fmt.Errorf("Error reading cos2: %v", err)
		}
	}

	if err = d.Set("cos3", flattenObjectSystemNpuIsfNpQueuesCos3(o["cos3"], d, "cos3")); err != nil {
		if vv, ok := fortiAPIPatch(o["cos3"], "ObjectSystemNpuIsfNpQueues-Cos3"); ok {
			if err = d.Set("cos3", vv); err != nil {
				return fmt.Errorf("Error reading cos3: %v", err)
			}
		} else {
			return fmt.Errorf("Error reading cos3: %v", err)
		}
	}

	if err = d.Set("cos4", flattenObjectSystemNpuIsfNpQueuesCos4(o["cos4"], d, "cos4")); err != nil {
		if vv, ok := fortiAPIPatch(o["cos4"], "ObjectSystemNpuIsfNpQueues-Cos4"); ok {
			if err = d.Set("cos4", vv); err != nil {
				return fmt.Errorf("Error reading cos4: %v", err)
			}
		} else {
			return fmt.Errorf("Error reading cos4: %v", err)
		}
	}

	if err = d.Set("cos5", flattenObjectSystemNpuIsfNpQueuesCos5(o["cos5"], d, "cos5")); err != nil {
		if vv, ok := fortiAPIPatch(o["cos5"], "ObjectSystemNpuIsfNpQueues-Cos5"); ok {
			if err = d.Set("cos5", vv); err != nil {
				return fmt.Errorf("Error reading cos5: %v", err)
			}
		} else {
			return fmt.Errorf("Error reading cos5: %v", err)
		}
	}

	if err = d.Set("cos6", flattenObjectSystemNpuIsfNpQueuesCos6(o["cos6"], d, "cos6")); err != nil {
		if vv, ok := fortiAPIPatch(o["cos6"], "ObjectSystemNpuIsfNpQueues-Cos6"); ok {
			if err = d.Set("cos6", vv); err != nil {
				return fmt.Errorf("Error reading cos6: %v", err)
			}
		} else {
			return fmt.Errorf("Error reading cos6: %v", err)
		}
	}

	if err = d.Set("cos7", flattenObjectSystemNpuIsfNpQueuesCos7(o["cos7"], d, "cos7")); err != nil {
		if vv, ok := fortiAPIPatch(o["cos7"], "ObjectSystemNpuIsfNpQueues-Cos7"); ok {
			if err = d.Set("cos7", vv); err != nil {
				return fmt.Errorf("Error reading cos7: %v", err)
			}
		} else {
			return fmt.Errorf("Error reading cos7: %v", err)
		}
	}

	return nil
}

func flattenObjectSystemNpuIsfNpQueuesFortiTestDebug(d *schema.ResourceData, fosdebugsn int, fosdebugbeg int, fosdebugend int) {
	log.Printf(strconv.Itoa(fosdebugsn))
	e := validation.IntBetween(fosdebugbeg, fosdebugend)
	log.Printf("ER List: %v", e)
}

func expandObjectSystemNpuIsfNpQueuesCos0(d *schema.ResourceData, v interface{}, pre string) (interface{}, error) {
	return v, nil
}

func expandObjectSystemNpuIsfNpQueuesCos1(d *schema.ResourceData, v interface{}, pre string) (interface{}, error) {
	return v, nil
}

func expandObjectSystemNpuIsfNpQueuesCos2(d *schema.ResourceData, v interface{}, pre string) (interface{}, error) {
	return v, nil
}

func expandObjectSystemNpuIsfNpQueuesCos3(d *schema.ResourceData, v interface{}, pre string) (interface{}, error) {
	return v, nil
}

func expandObjectSystemNpuIsfNpQueuesCos4(d *schema.ResourceData, v interface{}, pre string) (interface{}, error) {
	return v, nil
}

func expandObjectSystemNpuIsfNpQueuesCos5(d *schema.ResourceData, v interface{}, pre string) (interface{}, error) {
	return v, nil
}

func expandObjectSystemNpuIsfNpQueuesCos6(d *schema.ResourceData, v interface{}, pre string) (interface{}, error) {
	return v, nil
}

func expandObjectSystemNpuIsfNpQueuesCos7(d *schema.ResourceData, v interface{}, pre string) (interface{}, error) {
	return v, nil
}

func getObjectObjectSystemNpuIsfNpQueues(d *schema.ResourceData) (*map[string]interface{}, error) {
	obj := make(map[string]interface{})

	if v, ok := d.GetOk("cos0"); ok || d.HasChange("cos0") {
		t, err := expandObjectSystemNpuIsfNpQueuesCos0(d, v, "cos0")
		if err != nil {
			return &obj, err
		} else if t != nil {
			obj["cos0"] = t
		}
	}

	if v, ok := d.GetOk("cos1"); ok || d.HasChange("cos1") {
		t, err := expandObjectSystemNpuIsfNpQueuesCos1(d, v, "cos1")
		if err != nil {
			return &obj, err
		} else if t != nil {
			obj["cos1"] = t
		}
	}

	if v, ok := d.GetOk("cos2"); ok || d.HasChange("cos2") {
		t, err := expandObjectSystemNpuIsfNpQueuesCos2(d, v, "cos2")
		if err != nil {
			return &obj, err
		} else if t != nil {
			obj["cos2"] = t
		}
	}

	if v, ok := d.GetOk("cos3"); ok || d.HasChange("cos3") {
		t, err := expandObjectSystemNpuIsfNpQueuesCos3(d, v, "cos3")
		if err != nil {
			return &obj, err
		} else if t != nil {
			obj["cos3"] = t
		}
	}

	if v, ok := d.GetOk("cos4"); ok || d.HasChange("cos4") {
		t, err := expandObjectSystemNpuIsfNpQueuesCos4(d, v, "cos4")
		if err != nil {
			return &obj, err
		} else if t != nil {
			obj["cos4"] = t
		}
	}

	if v, ok := d.GetOk("cos5"); ok || d.HasChange("cos5") {
		t, err := expandObjectSystemNpuIsfNpQueuesCos5(d, v, "cos5")
		if err != nil {
			return &obj, err
		} else if t != nil {
			obj["cos5"] = t
		}
	}

	if v, ok := d.GetOk("cos6"); ok || d.HasChange("cos6") {
		t, err := expandObjectSystemNpuIsfNpQueuesCos6(d, v, "cos6")
		if err != nil {
			return &obj, err
		} else if t != nil {
			obj["cos6"] = t
		}
	}

	if v, ok := d.GetOk("cos7"); ok || d.HasChange("cos7") {
		t, err := expandObjectSystemNpuIsfNpQueuesCos7(d, v, "cos7")
		if err != nil {
			return &obj, err
		} else if t != nil {
			obj["cos7"] = t
		}
	}

	return &obj, nil
}
