module Awspec::Generator
  module Doc
    module Type
      class Nlb < Base
        def initialize
          super
          @type_name = 'NLB'
          @type = Awspec::Type::Nlb.new('my-nlb')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::Nlb::STATES.map { |state| 'be_' + state }.join(', '),
            'belong_to_vpc'
          ]
          @ignore_matchers = Awspec::Type::Nlb::STATES.map { |state| 'be_' + state }
          @describes = []
        end
      end
    end
  end
end
