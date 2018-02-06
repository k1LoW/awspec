module Awspec::Type
  class Elb < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_elb(@display_name)
    end

    def id
      @id ||= resource_via_client.load_balancer_name if resource_via_client
    end

    health_check_options = %w(
      target interval timeout
      unhealthy_threshold healthy_threshold
    )

    health_check_options.each do |option|
      define_method 'health_check_' + option do
        resource_via_client.health_check[option]
      end
    end

    def has_ec2?(id)
      ec2 = find_ec2(id)
      return nil unless ec2
      resource_via_client.instances.find do |instance|
        instance.instance_id == ec2.instance_id
      end
    end

    def has_security_group?(sg_id)
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
      subnets = resource_via_client.subnets
      ret = subnets.find do |s|
        s == subnet_id
      end
      return true if ret
      res = find_subnet(subnet_id)
      ret = subnets.find do |s|
        s == res.subnet_id
      end
    end

    def has_listener?(protocol:, port:, instance_protocol:, instance_port:)
      resource_via_client.listener_descriptions.find do |desc|
        listener = desc.listener
        listener.protocol == protocol && listener.load_balancer_port == port && \
          listener.instance_protocol == instance_protocol && listener.instance_port == instance_port
      end
    end

    def has_tag?(tag_key, tag_value)
      tag_set = select_all_elb_tags(@id)
      tag_set.find do |tag|
        tag.key == tag_key && tag.value == tag_value
      end
    end
  end
end
