module Awspec::Generator
  module Doc
    module Type
      class AlbTargetGroup < Base
        def initialize
          super
          @type_name = 'AlbTargetGroup'
          @type = Awspec::Type::AlbTargetGroup.new('my-alb-target-group')
          @ret = @type.resource_via_client
          @matchers = %w(belong_to_alb belong_to_vpc)
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
