module Awspec::Type
  class S3BucketAcl < Base
    def initialize(bucket)
      super
      @resource = find_s3_bucket_acl(bucket)
      @id = bucket if @resource
    end

    def has_grant?(conditions)
      evaluator = lambda do |obj, attr, val|
        if val.is_a?(Hash)
          o = obj.send(attr)
          val.all? { |a, v| evaluator.call(o, a, v) }
        else
          obj.send(attr) == val
        end
      end

      @resource.grants.find do |grant|
        conditions.all? { |attr, val| evaluator.call(grant, attr, val) }
      end
    end
  end
end
