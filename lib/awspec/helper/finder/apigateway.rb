module Awspec::Helper
  module Finder
    module Apigateway
      def find_apigateway(id)
        res = apigateway_client.get_rest_api({ rest_api_id: id })
      end
    end
  end
end
