module Awspec::Generator
  module Doc
    module Type
      class Eip < Base
        def initialize
          super
          @type_name = 'Elastic IP'
          @type = Awspec::Type::Eip.new('123.0.456.789')
          @ret = @type.resource_via_client
          @matchers = ['belong_to_domain']
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
