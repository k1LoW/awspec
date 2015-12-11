module Awspec::Generator
  module Doc
    module Type
      class Elasticache < Base
        def initialize
          super
          @type_name = 'Elasticache'
          @type = Awspec::Type::Elasticache.new('my-rep-group-001')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::Elasticache::STATES.map { |state| 'be_' + state.tr('-', '_') }.join(', '),
            'belong_to_vpc',
            'belong_to_replication_group',
            'belong_to_cache_subnet_group'
          ]
          @ignore_matchers = Awspec::Type::Elasticache::STATES.map { |state| 'be_' + state.tr('-', '_') }
          @describes = []
        end
      end
    end
  end
end
