module Awspec::Generator
  module Doc
    module Type
      class Rds < Base
        def initialize
          super
          @type_name = 'RDS'
          @type = Awspec::Type::Rds.new('my-rds')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::Rds::STATES.map { |state| 'be_' + state.tr('-', '_') }.join(', '),
            'belong_to_vpc',
            'belong_to_subnet',
            'belong_to_db_subnet_group'
          ]
          @ignore_matchers = Awspec::Type::Rds::STATES.map { |state| 'be_' + state.tr('-', '_') }
          @describes = %w(vpc_id)
        end
      end
    end
  end
end
