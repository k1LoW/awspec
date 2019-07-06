module Awspec::Type
  class S3Bucket < ResourceBase
    aws_resource Aws::S3::Bucket

    def resource_via_client
      @resource_via_client ||= find_bucket(@display_name)
    end

    def id
      @id ||= @display_name if resource_via_client
    end

    def has_object?(key)
      check_existence
      head_object(id, key)
    end

    def has_acl_grant?(grantee:, permission:)
      check_existence
      @acl = find_bucket_acl(id)
      @acl.grants.find do |grant|
        grant.permission == permission &&
          (grant.grantee.display_name == grantee || grant.grantee.uri == grantee || grant.grantee.id == grantee)
      end
    end

    def acl_owner
      check_existence
      @acl = find_bucket_acl(id)
      @acl.owner.display_name
    end

    def acl_grants_count
      check_existence
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
      check_existence
      bp = find_bucket_policy(id)

      if bp
        JSON.parse(bp.policy.read, array_class: Set) == JSON.parse(policy, array_class: Set)
      else
        false
      end
    end

    def has_tag?(key, value)
      check_existence
      tag = find_bucket_tag(id, key)
      return nil if tag.value != value
      tag
    end

    def has_logging_enabled?(target_bucket: nil, target_prefix: nil)
      check_existence
      bl = find_bucket_logging(id)
      le = bl ? bl.logging_enabled : nil

      return false if le.nil?
      return false if target_bucket && target_bucket != le.target_bucket
      return false if target_prefix && target_prefix != le.target_prefix
      true
    end

    def has_versioning_enabled?
      check_existence
      bv = find_bucket_versioning(id)
      bv ? (bv.status == 'Enabled') : false
    end

    def has_lifecycle_rule?(rule)
      check_existence
      lc_rule = lifecycle_configuration_rules.select { |r| r[:id] == rule[:id] }
      return false if lc_rule == []

      rule.all? do |key, value|
        lc_rule.each do |r|
          return false if value.is_a?(String) && r[key] != value
          if value.is_a?(Hash)
            return false if r[key].to_h != value
          end
          if value.is_a?(Array)
            return false if r[key].map(&:to_h) != value
          end
          true
        end
      end
    end

    def has_mfa_delete_enabled?
      check_existence
      bv = find_bucket_versioning(id)
      bv ? (bv.mfa_delete == 'Enabled') : false
    end

    def has_server_side_encryption?(algorithm:)
      check_existence
      configuration = find_bucket_server_side_encryption(id)
      return false unless configuration

      sse_algorithm = configuration.rules[0].apply_server_side_encryption_by_default.sse_algorithm
      sse_algorithm ? (sse_algorithm == algorithm) : false
    end

    private

    def cors_rules
      check_existence
      @cors ||= find_bucket_cors(id)
      @cors ? @cors.cors_rules : []
    end

    def lifecycle_configuration_rules
      blc = find_bucket_lifecycle_configuration(id)
      blc ? blc.rules : []
    end
  end
end
