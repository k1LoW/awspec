module Awspec::Generator
  module Doc
    module Type
      class ElasticacheCacheParameterGroup < Base
        def initialize
          super
          @type_name = 'ElasticacheCacheParameterGroup'
          @type = Awspec::Type::ElasticacheCacheParameterGroup.new('my-elasticache-cache-parameter-group')
          @ret = @type.resource
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
