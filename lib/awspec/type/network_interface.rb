module Awspec::Type
  class NetworkInterface < ResourceBase
    tags_allowed

    def resource_via_client
      @resource_via_client ||= find_network_interface(@display_name)
    end

    def id
      @id ||= resource_via_client.network_interface_id if resource_via_client
    end

    STATES = %w(
      available attaching in-use detaching
    )

    STATES.each do |state|
      define_method state.tr('-', '_') + '?' do
        resource_via_client.status == state
      end
    end

    def attached_to?(instance_id, device_index = nil)
      instance = find_ec2(instance_id)
      return false unless instance
      return false unless resource_via_client.attachment
      return false if device_index && resource_via_client.attachment.device_index != device_index
      resource_via_client.attachment.instance_id == instance.instance_id && \
        resource_via_client.attachment.status == 'attached'
    end

    def has_private_ip_address?(ip_address, primary = nil)
      resource_via_client.private_ip_addresses.find do |i|
        next false if !primary.nil? && i.primary != primary
        i.private_ip_address == ip_address
      end
    end

    def has_security_group?(sg_id)
      sgs = resource_via_client.groups
      ret = sgs.find do |sg|
        sg.group_id == sg_id || sg.group_name == sg_id
      end
      return true if ret
      sg2 = find_security_group(sg_id)
      return false unless sg2.tag_name == sg_id
      sgs.find do |sg|
        sg.group_id == sg2.group_id
      end
    end

    def private_ip_addresses_count
      resource_via_client.private_ip_addresses.count
    end
  end
end
