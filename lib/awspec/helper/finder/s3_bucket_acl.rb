module Awspec::Helper
  module Finder
    module S3BucketAcl
      def find_s3_bucket_acl(bucket)
        @s3_client.get_bucket_acl(bucket: bucket)
      rescue Aws::S3::Errors::NoSuchBucket
        nil
      end
    end
  end
end
