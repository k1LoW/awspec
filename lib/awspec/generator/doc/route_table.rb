module Awspec::Generator
  module Doc
    class RouteTable < Base
      def initialize
        @type_name = 'RouteTable'
        require File.dirname(__FILE__) + '/../../../../spec/stub/' + @type_name.to_snake_case
        @type = Awspec::Type::RouteTable.new('my-route-table')
        @ret = @type.route_table
        @matchers = []
        @ignore_matchers = []
        @describes = []
      end
    end
  end
end
