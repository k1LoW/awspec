module Awspec::Generator
  module Doc
    module Type
      class Ec2 < Base
        def initialize
          super
          @type_name = 'EC2'
          @type = Awspec::Type::Ec2.new('my-ec2')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::Ec2::STATES.map { |state| 'be_' + state.tr('-', '_') }.join(', '),
            'belong_to_vpc',
            'belong_to_subnet'
          ]
          @ignore_matchers = Awspec::Type::Ec2::STATES.map { |state| 'be_' + state.tr('-', '_') }
          @describes = []
        end
      end
    end
  end
end
