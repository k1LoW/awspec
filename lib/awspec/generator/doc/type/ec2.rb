module Awspec::Generator
  module Doc
    module Type
      class Ec2 < Base
        def initialize
          super
          @type_name = 'EC2'
          @type = Awspec::Type::Ec2.new('my-ec2')
          @ret = @type.resource
          @matchers = [
            'be_pending, be_running, be_shutting_down, be_terminated, be_stopping, be_stopped',
            'belong_to_vpc',
            'belong_to_subnet'
          ]
          @ignore_matchers = %w(
            be_pending be_running be_shutting_down
            be_terminated be_stopping be_stopped
          )
          @describes = []
        end
      end
    end
  end
end
