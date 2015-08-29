module Awspec::Generator
  module Doc
    module Type
      class Policy < Base
        def initialize
          super
          @type_name = 'policy'
          @type = Awspec::Type::Policy.new('my-policy')
          @ret = @type.policy
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
