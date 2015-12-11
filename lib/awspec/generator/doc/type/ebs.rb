module Awspec::Generator
  module Doc
    module Type
      class Ebs < Base
        def initialize
          super
          @type_name = 'EBS'
          @type = Awspec::Type::Ebs.new('my-ebs')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::Ebs::STATES.map { |state| 'be_' + state.tr('-', '_') }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::Ebs::STATES.map { |state| 'be_' + state.tr('-', '_') }
          @describes = []
        end
      end
    end
  end
end
