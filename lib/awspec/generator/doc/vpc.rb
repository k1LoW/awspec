module Awspec::Generator
  module Doc
    class Vpc < Base
      def initialize
        @type_name = 'VPC'
        require File.dirname(__FILE__) + '/../../../../spec/stub/' + @type_name.to_snake_case
        @type = Awspec::Type::Vpc.new('my-vpc')
        @ret = @type.vpc
        @matchers = []
        @ignore_matchers = []
        @describes = []
      end
    end
  end
end
