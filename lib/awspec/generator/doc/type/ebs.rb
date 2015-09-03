module Awspec::Generator
  module Doc
    module Type
      class Ebs < Base
        def initialize
          super
          @type_name = 'EBS'
          @type = Awspec::Type::Ebs.new('my-ebs')
          @ret = @type.resource
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
