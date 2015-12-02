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
        next false if !grantee.nil? && grant.grantee.display_name != grantee && grant.grantee.id != grantee
        next false if !permission.nil? && grant.permission != permission
        true
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
  end
end
