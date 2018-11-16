module Awspec::Generator
  module Doc
    module Type
      class Elb < Base
        def initialize
          super
          @type_name = 'ELB'
          @type = Awspec::Type::Elb.new('my-elb')
          @ret = @type.resource_via_client
          @matchers = %w(belong_to_vpc)
          @ignore_matchers = []
          @describes = %w(
            health_check_target health_check_interval health_check_timeout
            health_check_unhealthy_threshold health_check_healthy_threshold
            idle_timeout
          )
        end
      end
    end
  end
end
