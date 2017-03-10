module Awspec::Type
  class Ebs < ResourceBase
    aws_resource Aws::EC2::Volume
    tags_allowed

    def initialize(name)
      super
      @display_name = name
    end

    def resource_via_client
      @resource_via_client ||= find_ebs(@display_name)
    end

    def id
      @id ||= resource_via_client.volume_id if resource_via_client
    end

    STATES = %w(
      creating available in-use deleting deleted error
    )

    STATES.each do |state|
      define_method state.tr('-', '_') + '?' do
        resource_via_client.state == state
      end
    end

    def attached_to?(instance_id)
      instance = find_ec2(instance_id)
      return false unless instance
      return false unless resource_via_client.attachments
      resource_via_client.attachments.first.instance_id == instance.instance_id && \
        resource_via_client.attachments.first.state == 'attached'
    end
  end
end
