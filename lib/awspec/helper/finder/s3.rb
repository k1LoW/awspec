module Awspec::Helper
  module Finder
    module S3
      def find_bucket(id)
        s3_client.list_buckets[:buckets].find do |bucket|
          bucket.name == id
        end
      end

      def find_bucket_acl(id)
        s3_client.get_bucket_acl(bucket: id)
      rescue Aws::S3::Errors::ServiceError
        nil
      end

      def head_object(id, key)
        res = s3_client.head_object({
                                      bucket: id,
                                      key: key.sub(%r(\A/), '')
                                    })
        res.data.class == Aws::S3::Types::HeadObjectOutput
      rescue Aws::S3::Errors::NotFound
        false
      end

      def find_bucket_cors(id)
        s3_client.get_bucket_cors(bucket: id)
      rescue Aws::S3::Errors::ServiceError
        nil
      end

      def find_bucket_policy(id)
        s3_client.get_bucket_policy(bucket: id)
      rescue Aws::S3::Errors::ServiceError
        nil
      end

      def find_bucket_logging(id)
        s3_client.get_bucket_logging(bucket: id)
      rescue Aws::S3::Errors::ServiceError
        nil
      end

      def find_bucket_tag(id, tag_key)
        tag = nil
        begin
          bucket_tagging = s3_client.get_bucket_tagging(bucket: id)
          tag_set = bucket_tagging.tag_set
          tag = tag_set.find { |tag_obj| tag_obj.key == tag_key }
        rescue Aws::S3::Errors::ServiceError
          nil
        end
        return tag if tag
      end

      def find_bucket_versioning(id)
        s3_client.get_bucket_versioning(bucket: id)
      rescue Aws::S3::Errors::ServiceError
        nil
      end

      def find_bucket_lifecycle_configuration(id)
        s3_client.get_bucket_lifecycle_configuration(bucket: id)
      rescue Aws::S3::Errors::ServiceError
        nil
      end

      def find_bucket_server_side_encryption(id)
        res = s3_client.get_bucket_encryption(bucket: id)
        res.server_side_encryption_configuration
      rescue Aws::S3::Errors::ServiceError
        nil
      end

      def select_all_buckets
        s3_client.list_buckets.buckets
      end
    end
  end
end
