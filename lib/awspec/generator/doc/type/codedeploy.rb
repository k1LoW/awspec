module Awspec::Generator
  module Doc
    module Type
      class Codedeploy < Base
        def initialize
          super
          @type_name = 'Codedeploy'
          @type = Awspec::Type::Codedeploy.new('my-codedeploy')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
