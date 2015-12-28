module Awspec::Generator
  module Doc
    module Type
      class Ami < Base
        def initialize
          super
          @type_name = 'Ami'
          @type = Awspec::Type::Ami.new('my-ami')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
