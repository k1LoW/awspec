module Awspec::Type
  class Acm < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_certificate(@display_name)
    end

    def id
      @id ||= resource_via_client.certificate_arn if resource_via_client
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

    def has_domain_name?(domain)
      resource_via_client.domain_name == domain && \
      resource_via_client.certificate_arn == id
    end

    def has_domain_validation_option?(domain_name:, validation_method:, validation_status: nil)
      resource_via_client.domain_validation_options.find do |domain_validation_option|
        validation_status ||= domain_validation_option.validation_status
        domain_validation_option.domain_name == domain_name && \
        domain_validation_option.validation_method == validation_method && \
        domain_validation_option.validation_status == validation_status
      end
    end
  end
end
