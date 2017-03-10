module Awspec::Type
  class Ec2AccountAttributes < AccountAttributeBase
    def resource_via_client
      @resource_via_client ||= find_ec2_account_attributes
    end
  end
end
