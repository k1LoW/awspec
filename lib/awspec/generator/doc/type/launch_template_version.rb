module Awspec::Generator
  module Doc
    module Type
      class LaunchTemplateVersion < Base
        def initialize
          super
          @type_name = 'LaunchTemplateVersion'
          @type = Awspec::Type::LaunchTemplateVersion.new('my-launch-template')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
