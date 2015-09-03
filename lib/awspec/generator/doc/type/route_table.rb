module Awspec::Generator
  module Doc
    module Type
      class RouteTable < Base
        def initialize
          super
          @type = Awspec::Type::RouteTable.new('my-route-table')
          @ret = @type.resource
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
