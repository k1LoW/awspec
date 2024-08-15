# frozen_string_literal: true

module Awspec::Generator
  module Doc
    module Type
      class RdsDBParameterGroup < Base
        def initialize
          super
          @type = Awspec::Type::RdsDBParameterGroup.new('my-rds-db-parameter-group')
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
