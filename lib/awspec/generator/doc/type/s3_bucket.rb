module Awspec::Generator
  module Doc
    module Type
      class S3Bucket < Base
        def initialize
          super
          @type = Awspec::Type::S3Bucket.new('my-bucket')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = %w(acl_grants_count acl_owner cors_rules_count)
        end
      end
    end
  end
end
