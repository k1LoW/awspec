module Awspec::Generator
  module Doc
    class RdsDbParameterGroup < Base
      def initialize
        @type_name = 'RdsDbParameterGroup'
        require File.dirname(__FILE__) + '/../../../../spec/stub/' + @type_name.to_snake_case
        @type = Awspec::Type::RdsDbParameterGroup.new('my-rds-db-parameter-group')
        @ret = @type.parameters
        @matchers = []
        @ignore_matchers = []
        @describes = []
      end
    end
  end
end
