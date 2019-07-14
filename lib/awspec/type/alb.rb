module Awspec::Type
  class Alb < ResourceBase
    tags_allowed
    def resource_via_client
      @resource_via_client ||= find_alb(@display_name)
    end

    def id
      @id ||= resource_via_client.load_balancer_name if resource_via_client
    end

    STATES = %w(
      active provisioning failed
    )

    STATES.each do |state|
      define_method state + '?' do
        check_existence
        resource_via_client.state.code == state
      end
    end

    def has_security_group?(sg_id)
      check_existence
      sgs = resource_via_client.security_groups
      ret = sgs.find do |sg|
        sg == sg_id
      end
      return true if ret
      sg2 = find_security_group(sg_id)
      return true if sgs.include? sg2.group_id
      false
    end

    def has_subnet?(subnet_id)
      check_existence
      azs = resource_via_client.availability_zones
      ret = azs.find do |az|
        az.subnet_id == subnet_id
      end
      return true if ret
      subnet2 = find_subnet(subnet_id)
      subnet2.subnet_id = subnet_id
    end

    def has_tag?(tag_key, tag_value)
      alb_arn = resource_via_client.load_balancer_arn
      tag_set = select_all_alb_tags(alb_arn)
      tag_set.find do |tag|
        tag.key == tag_key && tag.value == tag_value
      end
    end
  end
end
