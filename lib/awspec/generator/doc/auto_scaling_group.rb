module Awspec::Generator
  module Doc
    class AutoScalingGroup < Base
      def initialize
        @type_name = 'AutoScalingGroup'
        require File.dirname(__FILE__) + '/../../../../spec/stub/' + @type_name.to_snake_case
        @type = Awspec::Type::AutoScalingGroup.new('my-auto-scaling-group')
        @ret = @type.group
        @matchers = []
        @ignore_matchers = []
        @describes = []
      end
    end
  end
end
