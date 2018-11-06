module Awspec::Generator
  module Doc
    module Type
      class SnsTopic < Base
        def initialize
          super
          @type_name = 'SnsTopic'
          @type = Awspec::Type::SnsTopic.new('my-sns')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
