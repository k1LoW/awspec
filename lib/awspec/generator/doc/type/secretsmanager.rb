module Awspec::Generator
  module Doc
    module Type
      class Secretsmanager < Base
        def initialize
          super
          @type_name = 'Secretsmanager'
          @type = Awspec::Type::Secretsmanager.new('my-secret')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
