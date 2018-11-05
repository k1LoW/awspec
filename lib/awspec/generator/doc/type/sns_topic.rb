module Awspec::Generator
  module Doc
    module Type
      class Sns < Base
        def initialize
          super
          @type_name = 'Sns'
          @type = Awspec::Type::Sns.new('my-sns')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
