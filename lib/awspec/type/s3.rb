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
  end
end
