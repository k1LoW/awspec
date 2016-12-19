module Awspec::Type
  class Ec2Running < Ec2
    def resource_via_client
      @resource_via_client ||= '' # FIXME
    end

    def id
     @id ||= '' # FIXME
    end
  end
end
