module Awspec::Generator
  module Doc
    module Type
      class ElasticBeanstalk < Base
        def initialize
          super
          @type_name = 'ElasticBeanstalk'
          @type = Awspec::Type::ElasticBeanstalk.new('my-elastic-beanstalk')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
