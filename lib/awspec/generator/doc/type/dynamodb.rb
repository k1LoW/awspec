module Awspec::Generator
  module Doc
    module Type
      class Dynamodb < Base
        def initialize
          super
          @type_name = 'Dynamodb'
          @type = Awspec::Type::Dynamodb.new('my-dynamodb-table')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::Dynamodb::STATUSES.map { |status| 'be_' + status.downcase }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::Dynamodb::STATUSES.map { |status| 'be_' + status.downcase }
          @describes = []
        end
      end
    end
  end
end
