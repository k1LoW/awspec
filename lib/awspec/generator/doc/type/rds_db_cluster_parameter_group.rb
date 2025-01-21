# frozen_string_literal: true

module Awspec::Generator
  module Doc
    module Type
      class RdsDBClusterParameterGroup < Base
        def initialize
          super
          @type = Awspec::Type::RdsDBClusterParameterGroup.new('my-rds-db-cluster-parameter-group')
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
