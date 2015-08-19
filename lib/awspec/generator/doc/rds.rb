module Awspec::Generator
  module Doc
    class Rds < Base
      def initialize
        @type_name = 'RDS'
        require File.dirname(__FILE__) + '/../../../../spec/stub/' + @type_name.to_snake_case
        @type = Awspec::Type::Rds.new('my-rds')
        @ret = @type.instance
        @matchers = %w(belong_to_vpc belong_to_subnet belong_to_db_subnet_group)
        @describes = %w(vpc_id)
      end
    end
  end
end
