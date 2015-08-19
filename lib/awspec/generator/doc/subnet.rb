module Awspec::Generator
  module Doc
    class Subnet < Base
      def initialize
        @type_name = 'Subnet'
        require File.dirname(__FILE__) + '/../../../../spec/stub/' + @type_name.to_snake_case
        @type = Awspec::Type::Subnet.new('my-route-table')
        @ret = @type.subnet
        @matchers = []
        @ignore_matchers = []
        @describes = []
      end
    end
  end
end
