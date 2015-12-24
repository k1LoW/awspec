module Awspec::Generator
  module Doc
    module Type
      class LaunchConfiguration < Base
        def initialize
          super
          @type_name = 'LaunchConfiguration'
          @type = Awspec::Type::LaunchConfiguration.new('my-lc')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
