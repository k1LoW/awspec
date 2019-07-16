module Awspec::Type
  class Ec2 < ResourceBase
    aws_resource Aws::EC2::Instance
    tags_allowed

    def initialize(name)
      super
      @display_name = name
    end

    def resource_via_client
      @resource_via_client ||= find_ec2(@display_name)
    end

    def id
      @id ||= resource_via_client.instance_id if resource_via_client
    end

    def security_group_count
      resource_via_client.security_groups.count
    end

    STATES = %w(
      pending running shutting-down
      terminated stopping stopped
    )

    STATES.each do |state|
      define_method state.tr('-', '_') + '?' do
        resource_via_client.state.name == state
      end
    end

    def disabled_api_termination?
      ret = find_ec2_attribute(id, 'disableApiTermination')
      ret.disable_api_termination.value
    end

    def has_eip?(ip_address = nil)
      option = {
        filters: [{ name: 'instance-id', values: [id] }]
      }
      option[:public_ips] = [ip_address] if ip_address
      ret = ec2_client.describe_addresses(option)
      return ret.addresses.count == 1 if ip_address
      return ret.addresses.count > 0 unless ip_address
    end

    def has_security_groups?(sg_ids)
      return true if match_group_ids?(sg_ids) || match_group_names?(sg_ids)

      group_ids = resource_security_groups.map { |sg| sg.group_id }
      tags = select_security_group_by_group_id(group_ids).map { |sg| sg.tags }.flatten
      group_names = tags.select { |tag| tag.key == 'Name' }.map { |tag| tag.value }
      group_names == sg_ids
    end

    def has_security_group?(sg_id)
      sgs = resource_via_client.security_groups
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

    def has_iam_instance_profile?(iam_instance_profile_name)
      iam = resource_via_client.iam_instance_profile
      ret = iam.arn.split('/').last == iam_instance_profile_name
      return true if ret
    end

    def has_ebs?(volume_id)
      blocks = resource_via_client.block_device_mappings
      ret = blocks.find do |block|
        next false unless block.ebs
        block.ebs.volume_id == volume_id
      end
      return true if ret
      blocks2 = find_ebs(volume_id)
      blocks2.attachments.find do |attachment|
        attachment.instance_id == id
      end
    end

    def has_network_interface?(network_interface_id, device_index = nil)
      res = find_network_interface(network_interface_id)
      interfaces = resource_via_client.network_interfaces
      interfaces.find do |interface|
        next false if device_index && interface.attachment.device_index != device_index
        interface.network_interface_id == res.network_interface_id
      end
    end

    def has_event?(event_code)
      status = find_ec2_status(id)
      status.events.find do |event|
        event.code == event_code
      end
    end

    def has_events?
      status = find_ec2_status(id)
      return false if status.nil?
      status.events.count > 0
    end

    def has_classiclink?(vpc_id = nil)
      option = {
        instance_ids: [id]
      }
      option[:filters] = [{ name: 'vpc-id', values: [vpc_id] }] if vpc_id
      ret = ec2_client.describe_classic_link_instances(option)
      return ret.instances.count == 1 if vpc_id
    end

    def has_classiclink_security_group?(sg_id)
      option = {
        instance_ids: [id]
      }
      classic_link_instances = ec2_client.describe_classic_link_instances(option)
      return false if classic_link_instances.instances.count == 0
      instances = classic_link_instances[0]
      sgs = instances[0].groups
      ret = sgs.find do |sg|
        sg.group_id == sg_id || sg.group_name == sg_id
      end
      return true if ret
    end

    def has_credit_specification?(cpu_credits)
      ret = find_ec2_credit_specifications(id)
      ret.cpu_credits == cpu_credits
    end

    private

    def match_group_ids?(sg_ids)
      sg_ids.sort == resource_security_groups.map { |sg| sg.group_id }.sort
    end

    def match_group_names?(sg_names)
      sg_names.sort == resource_security_groups.map { |sg| sg.group_name }.sort
    end

    def resource_security_groups
      resource_via_client.security_groups
    end
  end
end
