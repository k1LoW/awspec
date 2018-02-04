module Awspec::Type
  class CloudfrontDistribution < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_cloudfront_distribution(@display_name)
    end

    def id
      @id ||= resource_via_client.id if resource_via_client
    end

    STATUSES = %w(
      InProgress Deployed
    )

    STATUSES.each do |status|
      define_method status.underscore + '?' do
        resource_via_client.status == status
      end
    end

    def has_origin?(origin_id,
                    domain_name: nil,
                    origin_path: nil,
                    origin_access_identity: nil)
      return false unless [origin_id, domain_name].any?
      resource_via_client.origins.items.find do |origin|
        next false if !origin_id.nil? && origin.id != origin_id
        next false if !domain_name.nil? && origin.domain_name != domain_name
        next false if !origin_path.nil? && origin.origin_path != origin_path
        next false if !origin_access_identity.nil? && \
                      origin.s3_origin_config.origin_access_identity != origin_access_identity
        true
      end
    end

    def has_origin_domain_name?(domain_name)
      has_origin?(nil, domain_name: domain_name)
    end

    def has_origin_domain_name_and_path?(domain_name_and_path)
      domain_name = domain_name_and_path.gsub(%r(/.*\z), '')
      origin_path = domain_name_and_path.gsub(%r(\A[^/]*), '')
      has_origin?(nil, domain_name: domain_name, origin_path: origin_path)
    end

    def has_custom_response_error_code?(error_code,
                                        response_page_path: nil,
                                        response_code: nil,
                                        error_caching_min_ttl: nil)
      return false unless [error_code, domain_name].any?
      resource_via_client.custom_error_responses.items.find do |error|
        next false if !error_code.nil? && error.error_code != error_code
        next false if !response_page_path.nil? && error.response_page_path != response_page_path
        next false if !response_code.nil? && error.response_code != response_code.to_s
        next false if !error_caching_min_ttl.nil? && error.error_caching_min_ttl != error_caching_min_ttl
        true
      end
    end
  end
end
