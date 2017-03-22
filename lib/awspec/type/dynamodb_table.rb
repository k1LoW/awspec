module Awspec::Type
  class DynamodbTable < ResourceBase
    aws_resource Aws::DynamoDB::Table

    def resource_via_client
      @resource_via_client ||= find_dynamodb_table(@display_name)
    end

    def id
      @id ||= resource_via_client.table_name if resource_via_client
    end

    STATUSES = %w(
      CREATING
      UPDATING
      DELETING
      ACTIVE
    )

    STATUSES.each do |status|
      define_method status.downcase + '?' do
        resource_via_client.table_status == status
      end
    end

    def has_attribute_definition?(name, type)
      ret = resource_via_client.attribute_definitions.select { |a| a.attribute_name == name }
      return false if ret.empty?
      return false unless ret.single_resource.attribute_type == type
      return true if ret.single_resource.attribute_name == name
    end

    def has_key_schema?(name, type)
      ret = resource_via_client.key_schema.select { |k| k.attribute_name == name }
      return false if ret.empty?
      return false unless ret.single_resource.key_type == type
      return true if ret.single_resource.attribute_name == name
    end
  end
end
