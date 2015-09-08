module Awspec::Generator
  module Doc
    module Type
      class RdsDbParameterGroup < Base
        def initialize
          super
          @type = Awspec::Type::RdsDbParameterGroup.new('my-rds-db-parameter-group')
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
