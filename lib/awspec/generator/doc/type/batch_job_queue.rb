module Awspec::Generator
  module Doc
    module Type
      class BatchJobQueue < Base
        def initialize
          super
          @type_name = 'BatchJobQueue'
          @type = Awspec::Type::BatchJobQueue.new('my-batch-job-queue')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
