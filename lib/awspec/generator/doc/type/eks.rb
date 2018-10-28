module Awspec::Generator
  module Doc
    module Type
      class Eks < Base
        def initialize
          super
          @type_name = 'Eks'
          @type = Awspec::Type::Eks.new('my-eks')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::Eks::STATES.map { |state| 'be_' + state.downcase }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::Eks::STATES.map { |state| 'be_' + state.downcase }

          @describes = []
        end
      end
    end
  end
end
