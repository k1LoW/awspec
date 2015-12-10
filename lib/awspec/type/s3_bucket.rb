module Awspec::Type
  class S3Bucket < Base
    def initialize(id)
      super
      @resource = find_bucket(id)
      @id = id if @resource
    end

    def has_object?(key)
      res = @s3_client.head_object({
                                     bucket: @id,
                                     key: key.sub(%r(\A/), '')
                                   })
      res
    rescue
      false
    end

    def has_acl_grant?(grantee:, permission:)
      @acl = find_bucket_acl(@id)
      @acl.grants.find do |grant|
        grant.permission == permission &&
          (grant.grantee.display_name == grantee || grant.grantee.uri == grantee || grant.grantee.id == grantee)
      end
    end

    def acl_owner
      @acl = find_bucket_acl(@id)
      @acl.owner.display_name
    end

    def acl_grants_count
      @acl = find_bucket_acl(@id)
      @acl.grants.count
    end

    def has_cors_rule?(allowed_headers: [],
                       allowed_methods:,
                       allowed_origins:,
                       expose_headers: [],
                       max_age_seconds: nil)
      cors_rules.any? do |rule|
        (rule.allowed_headers - allowed_headers).empty? &&
          (rule.allowed_methods - allowed_methods).empty? &&
          (rule.allowed_origins - allowed_origins).empty? &&
          (rule.expose_headers - expose_headers).empty? &&
          rule.max_age_seconds == max_age_seconds
      end
    end

    def cors_rules_count
      cors_rules.count
    end

    def has_policy?(policy)
      bp = find_bucket_policy(@id)
      # newlines, spaces, etc.. are removed from policy which is returned from API
      bp ? (bp.policy.read == policy.gsub(/(\n|\r|\r\n|\s|\t)/, '')) : false
    end

    def real_resource
      @real_resource ||= Awspec::ResourceReader.new(Aws::S3::Bucket.new(@id))
    end

    private

    def cors_rules
      cors = find_bucket_cors(@id)
      cors ? cors.cors_rules : []
    end
  end
end
