module Awspec::Generator
  module Doc
    module Type
      class Efs < Base
        def initialize
          super
          @type_name = 'EFS'
          @type = Awspec::Type::Efs.new('my-efs')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
