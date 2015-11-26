module Awspec::Type
  class S3BucketAcl < Base
    def initialize(bucket)
      super
      @resource = find_s3_bucket_acl(bucket)
      @id = bucket if @resource
    end
  end
end
