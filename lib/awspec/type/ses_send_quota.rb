module Awspec::Type
  class SesSendQuota < Base
    def resource_via_client
      @resource_via_client ||= find_ses_send_quota
    end

    def id
      @id ||= resource_via_client if resource_via_client
    end
  end
end
