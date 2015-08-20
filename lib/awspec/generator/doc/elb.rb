module Awspec::Generator
  module Doc
    class Elb < Base
      def initialize
        @type_name = 'ELB'
        require File.dirname(__FILE__) + '/../../../../spec/stub/' + @type_name.to_snake_case
        @type = Awspec::Type::Elb.new('my-elb')
        @ret = @type.lb
        @matchers = %w(belong_to_vpc belong_to_subnet)
        @ignore_matchers = []
        @describes = %w(
          health_check_target health_check_interval health_check_timeout
          health_check_unhealthy_threshold health_check_healthy_threshold
        )
      end
    end
  end
end
