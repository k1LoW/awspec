module Awspec::Generator
  module Doc
    class Ec2 < Base
      def initialize
        @type_name = 'EC2'
        require File.dirname(__FILE__) + '/../../../../spec/stub/' + @type_name.to_snake_case
        @type = Awspec::Type::Ec2.new('my-ec2')
        @ret = @type.instance
        @matchers = %w(belong_to_vpc belong_to_subnet)
        @ignore_matchers = []
        @describes = []
      end
    end
  end
end
