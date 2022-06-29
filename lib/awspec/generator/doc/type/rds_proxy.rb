# frozen_string_literal: true

module Awspec::Generator
  module Doc
    module Type
      class RdsProxy < Base
        def initialize
          super
          @type_name = 'RdsProxy'
          @type = Awspec::Type::RdsProxy.new('my-rds-proxy')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::RdsProxy::STATES.map { |state| "be_#{state.tr('-', '_')}" }.join(', '),
            'belong_to_vpc',
            'belong_to_subnet'
          ]
          @ignore_matchers = Awspec::Type::RdsProxy::STATES.map { |state| "be_#{state.tr('-', '_')}" }
          @describes = %w[vpc_id]
        end
      end
    end
  end
end
