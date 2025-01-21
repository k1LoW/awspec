# frozen_string_literal: true

module Awspec::Generator
  module Doc
    module Type
      class RdsDBCluster < Base
        def initialize
          super
          @type_name = 'RdsDBCluster'
          @type = Awspec::Type::RdsDBCluster.new('my-rds-db-cluster')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::RdsDBCluster::STATES.map { |state| "be_#{state.tr('-', '_')}" }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::RdsDBCluster::STATES.map { |state| "be_#{state.tr('-', '_')}" }
          @describes = []
        end
      end
    end
  end
end
