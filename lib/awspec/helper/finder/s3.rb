module Awspec::Helper
  module Finder
    module S3
      def find_bucket(id)
        res = @s3_client.list_buckets
        ret = @s3_client.list_buckets[:buckets].find do |bucket|
          bucket.name == id
        end
      end

      def find_bucket_acl(id)
        @s3_client.get_bucket_acl(bucket: id)
      rescue Aws::S3::Errors::NoSuchBucket
        nil
      end

      def find_bucket_cors(id)
        @s3_client.get_bucket_cors(bucket: id)
      rescue Aws::S3::Errors::NoSuchBucket
        nil
      end

      def find_bucket_policy(id)
        @s3_client.get_bucket_policy(bucket: id)
      rescue Aws::S3::Errors::NoSuchBucket
        nil
      end

      def select_all_buckets
        @s3_client.list_buckets.buckets
      end
    end
  end
end
