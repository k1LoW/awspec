module Awspec::Generator
  module Doc
    module Type
      class LaunchTemplate < Base
        def initialize
          super
          @type_name = 'LaunchTemplate'
          @type = Awspec::Type::LaunchTemplate.new('my-launch-template')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
