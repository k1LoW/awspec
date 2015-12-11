module Awspec::Generator
  module Doc
    module Type
      class Vpc < Base
        def initialize
          super
          @type_name = 'VPC'
          @type = Awspec::Type::Vpc.new('my-vpc')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::Vpc::STATES.map { |state| 'be_' + state.tr('-', '_') }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::Vpc::STATES.map { |state| 'be_' + state.tr('-', '_') }
          @describes = []
        end
      end
    end
  end
end
