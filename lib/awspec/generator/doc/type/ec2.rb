module Awspec::Generator
  module Doc
    module Type
      class Ec2 < Base
        def initialize
          super
          @type_name = 'EC2'
          @type = Awspec::Type::Ec2.new('my-ec2')
          @ret = @type.instance
          @matchers = %w(belong_to_vpc belong_to_subnet)
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
