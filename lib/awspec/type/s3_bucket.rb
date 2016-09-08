module Awspec::Type
  class S3Bucket < Base
    aws_resource Aws::S3::Bucket

    def resource_via_client
      @resource_via_client ||= find_bucket(@display_name)
    end

    def id
      @id ||= @display_name if resource_via_client
    end

    def has_object?(key)
      res = s3_client.head_object({
                                    bucket: id,
                                    key: key.sub(%r(\A/), '')
                                  })
      res
    rescue
      false
    end

    def has_acl_grant?(grantee:, permission:)
      @acl = find_bucket_acl(id)
      @acl.grants.find do |grant|
        grant.permission == permission &&
          (grant.grantee.display_name == grantee || grant.grantee.uri == grantee || grant.grantee.id == grantee)
      end
    end

    def acl_owner
      @acl = find_bucket_acl(id)
      @acl.owner.display_name
    end

    def acl_grants_count
      @acl = find_bucket_acl(id)
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
      bp = find_bucket_policy(id)
      if bp
        JSON.parse(bp.policy.read, array_class: Set) == JSON.parse(policy, array_class: Set)
      else
        false
      end
    end

    def has_logging_enabled?(target_bucket: nil, target_prefix: nil)
      bl = find_bucket_logging(id)
      le = bl ? bl.logging_enabled : nil

      return false if le.nil?
      return false if target_bucket && target_bucket != le.target_bucket
      return false if target_prefix && target_prefix != le.target_prefix
      true
    end

    def has_versioning_enabled?
      bv = find_bucket_versioning(id)
      bv ? (bv.status == 'Enabled') : false
    end

    def has_mfa_delete_enabled?
      bv = find_bucket_versioning(id)
      bv ? (bv.mfa_delete == 'Enabled') : false
    end

    private

    def cors_rules
      cors = find_bucket_cors(id)
      cors ? cors.cors_rules : []
    end
  end
end
