module Awspec::Generator
  module Doc
    module Type
      class Elasticache < Base
        def initialize
          super
          @type_name = 'Elasticache'
          @type = Awspec::Type::Elasticache.new('my-elasticache')
          @ret = @type.resource
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
