module Awspec::Type
  class LambdaAccountSettings < AccountAttributeBase
    def resource_via_client
      @resource_via_client ||= find_lambda_account_settings
    end
  end
end
