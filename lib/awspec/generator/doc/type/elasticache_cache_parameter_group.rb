module Awspec::Generator
  module Doc
    module Type
      class ElasticacheCacheParameterGroup < Base
        def initialize
          super
          @type_name = 'ElasticacheCacheParameterGroup'
          @type = Awspec::Type::ElasticacheCacheParameterGroup.new('my-cache-parameter-group')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
