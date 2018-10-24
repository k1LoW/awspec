module Awspec::Generator
  module Doc
    module Type
      class BatchComputeEnvironment < Base
        def initialize
          super
          @type_name = 'BatchComputeEnvironment'
          @type = Awspec::Type::BatchComputeEnvironment.new('my-batch-compute-environment')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::BatchComputeEnvironment::STATES.map { |state| 'be_' + state.downcase }.join(', '),
            Awspec::Type::BatchComputeEnvironment::TYPES.map { |type| 'be_' + type.downcase }.join(', ')
          ]
          @ignore_matchers = [
            Awspec::Type::BatchComputeEnvironment::STATES.map { |state| 'be_' + state.downcase }.join(', '),
            Awspec::Type::BatchComputeEnvironment::TYPES.map { |type| 'be_' + type.downcase }.join(', ')
          ]
          @describes = []
        end
      end
    end
  end
end
