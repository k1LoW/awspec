module Awspec::Generator
  module Doc
    module Type
      class S3BucketAcl < Base
        def initialize
          super
          @type_name = 'S3BucketAcl'
          @type = Awspec::Type::S3BucketAcl.new('my-bucket')
          @ret = @type.resource
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
