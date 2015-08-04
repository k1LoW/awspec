module Awspec::Helper
  module Finder
    module S3
      def find_bucket(id)
        res = @s3_client.list_buckets
        ret = @s3_client.list_buckets[:buckets].find do |bucket|
          bucket.name == id
        end
      end
    end
  end
end
