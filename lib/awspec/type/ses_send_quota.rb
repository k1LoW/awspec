module Awspec::Type
  class SesSendQuota < AccountBase
    def resource_via_client
      @resource_via_client ||= find_ses_send_quota
    end
  end
end
