module Awspec::Generator
  module Doc
    module Type
      class BatchComputeEnvironment < Base
        def initialize
          super
          @type_name = 'BatchComputeEnvironment'
          @type = Awspec::Type::BatchComputeEnvironment.new('my-batch-compute-environment')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
