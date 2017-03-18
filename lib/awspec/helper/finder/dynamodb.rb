module Awspec::Helper
  module Finder
    module Dynamodb
      def find_dynamodb_table(id)
        resource = dynamodb_client.describe_table({ table_name: id }).table
        return resource if resource.table_name == id
      end
    end
  end
end
