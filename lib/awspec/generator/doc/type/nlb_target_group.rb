module Awspec::Generator
  module Doc
    module Type
      class NlbTargetGroup < Base
        def initialize
          super
          @type_name = 'NlbTargetGroup'
          @type = Awspec::Type::NlbTargetGroup.new('my-nlb-target-group')
          @ret = @type.resource_via_client
          @matchers = %w(belong_to_nlb belong_to_vpc)
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
