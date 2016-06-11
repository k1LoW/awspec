module Awspec::Generator
  module Doc
    module Type
      class RdsDbClusterParameterGroup < Base
        def initialize
          super
          @type = Awspec::Type::RdsDbClusterParameterGroup.new('my-rds-db-cluster-parameter-group')
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
