module Awspec::Generator
  module Doc
    module Type
      class BatchJobDefinition < Base
        def initialize
          super
          @type_name = 'BatchJobDefinition'
          @type = Awspec::Type::BatchJobDefinition.new('my-batch-job-definition')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
