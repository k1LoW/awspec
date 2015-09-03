module Awspec::Generator
  module Doc
    module Type
      class Vpc < Base
        def initialize
          super
          @type_name = 'VPC'
          @type = Awspec::Type::Vpc.new('my-vpc')
          @ret = @type.resource
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
