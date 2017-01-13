module Awspec::Type
  class Ec2Running < Ec2
    def resource_via_client
      @resource_via_client ||= find_running_ec2(@display_name)
    end
  end
end
