module Awspec::Generator
  module Doc
    module Type
      class Sqs < Base
        def initialize
          super
          @type_name = 'SQS'
          @type = Awspec::Type::Sqs.new('my-queue')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = @type.resource_via_client.keys
        end
      end
    end
  end
end
