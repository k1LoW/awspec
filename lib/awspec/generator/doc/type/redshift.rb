module Awspec::Generator
  module Doc
    module Type
      class Redshift < Base
        def initialize
          super
          @type_name = 'Redshift'
          @type = Awspec::Type::Redshift.new('my-redshift')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::Redshift::STATES.map { |state| 'be_' + state.tr('-', '_') }.join(', '),
            'belong_to_vpc',
            'belong_to_cluster_subnet_group'
          ]
          @ignore_matchers = Awspec::Type::Redshift::STATES.map { |state| 'be_' + state.tr('-', '_') }
          @describes = %w(vpc_id)
        end
      end
    end
  end
end
