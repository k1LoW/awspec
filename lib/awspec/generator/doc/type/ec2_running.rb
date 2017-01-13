module Awspec::Generator
  module Doc
    module Type
      class Ec2Running < Base
        def initialize
          super
          @type_name = 'Ec2Running'
          @type = Awspec::Type::Ec2Running.new('my-ec2-running')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
