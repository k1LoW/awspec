module Awspec::Generator
  module Doc
    module Type
      class Subnet < Base
        def initialize
          super
          @type = Awspec::Type::Subnet.new('my-route-table')
          @ret = @type.resource
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
