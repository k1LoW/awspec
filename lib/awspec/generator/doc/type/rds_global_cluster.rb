# frozen_string_literal: true

module Awspec::Generator
  module Doc
    module Type
      class RdsGlobalCluster < Base
        def initialize
          super
          @type_name = 'RdsGlobalCluster'
          @type = Awspec::Type::RdsGlobalCluster.new('my-rds-global-cluster')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::RdsGlobalCluster::STATES.map { |state| "be_#{state.tr('-', '_')}" }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::RdsGlobalCluster::STATES.map { |state| "be_#{state.tr('-', '_')}" }
          @describes = []
        end
      end
    end
  end
end
