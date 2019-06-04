module Awspec::Generator
  module Doc
    module Type
      class Alb < Base
        def initialize
          super
          @type_name = 'ALB'
          @type = Awspec::Type::Alb.new('my-alb')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::Alb::STATES.map { |state| 'be_' + state }.join(', '),
            'belong_to_vpc',
            # 'have_tag'
          ]
          @ignore_matchers = Awspec::Type::Alb::STATES.map { |state| 'be_' + state }
          @describes = []
        end
      end
    end
  end
end
