module Awspec::Generator
  module Doc
    module Type
      class Alb < Base
        def initialize
          super
          @type_name = 'Alb'
          @type = Awspec::Type::Alb.new('my-alb')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
