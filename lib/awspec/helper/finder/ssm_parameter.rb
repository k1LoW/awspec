module Awspec::Helper
  module Finder
    module SsmParameter
      def find_ssm_parameter(name)
        ssm_client.describe_parameters(
          {
            filters:  [
              {
                key: 'Name',
                values: [name]
              }
            ]
          }).parameters[0]
      end

      def find_parameter_tag(id, tag_key)
        tag = nil
        begin
          response = ssm_client.list_tags_for_resource(
            resource_type: 'Parameter',
            resource_id: id
          )
          tag_set = response.tag_list
          tag = tag_set.find { |tag_obj| tag_obj.key == tag_key }
        rescue Aws::SSM::Errors::ServiceError
          nil
        end
        return tag if tag
      end
    end
  end
end
