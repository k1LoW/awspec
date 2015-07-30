module Awspec::Type
  class S3 < Base
    attr_reader :client, :bucket

    def initialize(id)
      super
      @client = Aws::S3::Client.new
      res = @client.list_buckets
      ret = @client.list_buckets[:buckets].find do |bucket|
        bucket.name == id
      end
      @id = id if ret
      @bucket = ret
    end

    def has_object?(key)
      res = @client.head_object({
                                  bucket: @id,
                                  key: key.sub(%r(\A/), '')
                                })
      res
      rescue
        false
    end
  end
end
