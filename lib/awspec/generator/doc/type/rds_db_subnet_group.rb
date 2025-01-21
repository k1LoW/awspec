# frozen_string_literal: true

module Awspec::Generator
  module Doc
    module Type
      class RdsDBSubnetGroup < Base
        def initialize
          super
          @type_name = 'RdsDBSubnetGroup'
          @type = Awspec::Type::RdsDBSubnetGroup.new('my-rds-db-subnet-group')
          @ret = @type.resource_via_client
          @matchers = %w[belong_to_vpc belong_to_subnet]
          @ignore_matchers = []
          @describes = %w[vpc_id]
        end
      end
    end
  end
end
