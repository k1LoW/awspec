module Awspec::Generator
  module Doc
    module Type
      class Dynamodb < Base
        def initialize
          super
          @type_name = 'Dynamodb'
          @type = Awspec::Type::Dynamodb.new('my-dynamodb-table')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
