module Awspec::Generator
  module Doc
    module Type
      class Subnet < Base
        def initialize
          super
          @type = Awspec::Type::Subnet.new('my-route-table')
          @ret = @type.subnet
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
