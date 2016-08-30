module Awspec::Generator
  module Doc
    module Type
      class Elasticsearch < Base
        def initialize
          super
          @type_name = 'Elasticsearch'
          @type = Awspec::Type::Elasticsearch.new('my-elasticsearch')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
