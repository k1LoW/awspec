module Awspec::Type
  class Acm < Base
    def resource_via_client
      @resource_via_client ||= find_certificate(@display_name)
    end

    def id
      @id = resource_via_client.certificate_arn if resource_via_client
    end

    STATUSES = %w(
      PENDING_VALIDATION
      ISSUED
      INACTIVE
      EXPIRED
      VALIDATION_TIMED_OUT
      REVOKED
      FAILED
    )

    STATUSES.each do |status|
      define_method status.downcase + '?' do
        resource_via_client.status == status
      end
    end
  end
end
