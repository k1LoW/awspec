module Awspec::Type
  class LaunchConfiguration < Base
    def initialize(id)
      super
      @resource_via_client = find_launch_configuration(id)
      @id = @resource_via_client.launch_configuration_arn if @resource_via_client
    end

    def has_security_group?(sg_id)
      sgs = @resource_via_client.security_groups
      ret = sgs.find do |sg|
        sg == sg_id
      end
      return true if ret
      sg2 = find_security_group(sg_id)
      sgs.find do |sg|
        sg == sg2.group_id
      end
    end
  end
end
