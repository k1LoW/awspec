# frozen_string_literal: true

module Awspec::Helper
  module Finder
    module SsmParameter
      def find_ssm_parameter(name)
        req = {
          filters:  [
            {
              key: 'Name',
              values: [name]
            }
          ]
        }
        loop do
          res = ssm_client.describe_parameters(req)
          if res.parameters.size >= 1
            return res.parameters.first
          end
          break if res.next_token.nil?
          req[:next_token] = res.next_token
        end
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
