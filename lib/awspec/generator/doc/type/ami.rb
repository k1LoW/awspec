module Awspec::Generator
  module Doc
    module Type
      class Ami < Base
        def initialize
          super
          @type_name = 'AMI'
          @type = Awspec::Type::Ami.new('my-ami')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::Ami::STATES.map { |state| 'be_' + state }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::Ami::STATES.map { |state| 'be_' + state.tr('-', '_') }
          @describes = []
        end
      end
    end
  end
end
