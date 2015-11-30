module Awspec::Type
  class S3 < Base
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

    def has_acl?(grantee:, permission:, type: nil)
      @acl = find_s3_bucket_acl(@id)
      @acl.grants.find do |grant|
        next false if !grantee.nil? && grant.grantee.display_name != grantee && grant.grantee.id != grantee
        next false if !permission.nil? && grant.permission != permission
        next false if !type.nil? && grant.grantee.type != type
        true
      end
    end

    def bucket_acl_owner
      @acl = find_s3_bucket_acl(@id)
      @acl.owner.display_name
    end
  end
end
