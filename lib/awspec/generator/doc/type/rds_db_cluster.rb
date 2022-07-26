# frozen_string_literal: true

module Awspec::Generator
  module Doc
    module Type
      class RdsDbCluster < Base
        def initialize
          super
          @type_name = 'RdsDbCluster'
          @type = Awspec::Type::RdsDbCluster.new('my-rds-db-cluster')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::RdsDbCluster::STATES.map { |state| "be_#{state.tr('-', '_')}" }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::RdsDbCluster::STATES.map { |state| "be_#{state.tr('-', '_')}" }
          @describes = []
        end
      end
    end
  end
end
