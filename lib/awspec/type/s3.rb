module Awspec::Type
  class S3 < Base
    attr_reader :bucket

    def initialize(id)
      super
      @bucket = find_bucket(id)
      @id = id if @bucket
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
  end
end
