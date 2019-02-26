module Awspec::Generator
  module Doc
    module Type
      class Mq < Base
        def initialize
          super
          @type_name = 'MQ'
          @type = Awspec::Type::Mq.new('my-mq')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::Mq::STATES.map { |state| 'be_' + state.tr('-', '_') }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::Mq::STATES.map { |state| 'be_' + state.tr('-', '_') }
          @describes = %w(vpc_id)
        end
      end
    end
  end
end
