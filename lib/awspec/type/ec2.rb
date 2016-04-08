module Awspec::Type
  class Ec2 < Base
    aws_resource Aws::EC2::Instance
    tags_allowed

    def initialize(id)
      super
      @resource_via_client = find_ec2(id)
      @id = @resource_via_client.instance_id if @resource_via_client
    end

    STATES = %w(
      pending running shutting-down
      terminated stopping stopped
    )

    STATES.each do |state|
      define_method state.tr('-', '_') + '?' do
        @resource_via_client.state.name == state
      end
    end

    def disabled_api_termination?
      ret = find_ec2_attribute(@id, 'disableApiTermination')
      ret.disable_api_termination.value
    end

    def has_eip?(ip_address = nil)
      option = {
        filters: [{ name: 'instance-id', values: [@id] }]
      }
      option[:public_ips] = [ip_address] if ip_address
      ret = ec2_client.describe_addresses(option)
      return ret.addresses.count == 1 if ip_address
      return ret.addresses.count > 0 unless ip_address
    end

    def has_security_group?(sg_id)
      sgs = @resource_via_client.security_groups
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

    def has_ebs?(volume_id)
      blocks = @resource_via_client.block_device_mappings
      ret = blocks.find do |block|
        next false unless block.ebs
        block.ebs.volume_id == volume_id
      end
      return true if ret
      blocks2 = find_ebs(volume_id)
      blocks2.attachments.find do |attachment|
        attachment.instance_id == @id
      end
    end

    def has_event?(event_code)
      status = find_ec2_status(@id)
      ret = status.events.find do |event|
        event.code == event_code
      end
    end

    def has_events?
      status = find_ec2_status(@id)
      return false if status.nil?
      status.events.count > 0
    end
  end
end
