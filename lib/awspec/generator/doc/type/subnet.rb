module Awspec::Generator
  module Doc
    module Type
      class Subnet < Base
        def initialize
          super
          @type = Awspec::Type::Subnet.new('my-route-table')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::Subnet::STATES.map { |state| 'be_' + state.tr('-', '_') }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::Subnet::STATES.map { |state| 'be_' + state.tr('-', '_') }
          @describes = []
        end
      end
    end
  end
end
