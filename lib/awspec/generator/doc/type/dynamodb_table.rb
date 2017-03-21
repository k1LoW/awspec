module Awspec::Generator
  module Doc
    module Type
      class DynamodbTable < Base
        def initialize
          super
          @type_name = 'DynamodbTable'
          @type = Awspec::Type::DynamodbTable.new('my-dynamodb-table')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::DynamodbTable::STATUSES.map { |status| 'be_' + status.downcase }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::DynamodbTable::STATUSES.map { |status| 'be_' + status.downcase }
          @describes = []
        end
      end
    end
  end
end
