module Awspec::Type
  class RdsAccountAttributes < AccountAttributeBase
    def resource_via_client
      @resource_via_client ||= find_rds_account_attributes
    end
  end
end
