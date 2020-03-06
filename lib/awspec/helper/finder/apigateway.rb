module Awspec::Helper
  module Finder
    module Apigateway
      def find_apigateway_by_id(id)
        apis = []
        apigateway_client.get_rest_apis(limit: 500).each do |response|
          apis += response.items
        end
        apis.each do |api|
          return api if api.id == id
        end
        nil
      end

      def find_apigateway_by_name(name)
        apis = []
        apigateway_client.get_rest_apis(limit: 500).each do |response|
          apis += response.items
        end
        apis.each do |api|
          return api if api.name == name
        end
        nil
      end
    end
  end
end
