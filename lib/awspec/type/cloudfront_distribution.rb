module Awspec::Type
  class CloudfrontDistribution < Base
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
  end
end
