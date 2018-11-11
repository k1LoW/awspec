module Awspec::Generator
  module Doc
    module Type
      class Emr < Base
        def initialize
          super
          @type_name = 'Emr'
          @type = Awspec::Type::Emr.new('my-emr')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::Emr::STATES.map { |state| 'be_' + state.downcase }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::Emr::STATES.map { |state| 'be_' + state.downcase }
          @describes = []
        end
      end
    end
  end
end
