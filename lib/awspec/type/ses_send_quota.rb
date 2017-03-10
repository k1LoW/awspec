module Awspec::Type
  class SesSendQuota < AccountAttributeBase
    def resource_via_client
      @resource_via_client ||= find_ses_send_quota
    end
  end
end
