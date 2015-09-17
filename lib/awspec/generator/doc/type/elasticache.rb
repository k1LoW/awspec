module Awspec::Generator
  module Doc
    module Type
      class Elasticache < Base
        def initialize
          super
          @type_name = 'Elasticache'
          @type = Awspec::Type::Elasticache.new('my-rep-group-001')
          @ret = @type.resource
          @matchers = %w(belong_to_vpc belong_to_replication_group belong_to_cache_subnet_group)
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
