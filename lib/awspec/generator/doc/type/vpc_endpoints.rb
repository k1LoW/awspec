# frozen_string_literal: true

module Awspec::Generator
  module Doc
    module Type
      class VpcEndpoints < Base
        def initialize
          super
          @type_name = 'VpcEndpoints'
          @type = Awspec::Type::VpcEndpoints.new('my-vpc-endpoint')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::VpcEndpoints::STATES.map { |state| "be_#{state.tr('-', '_')}" }.join(', '),
            'belong_to_vpc'
          ]
          @ignore_matchers = Awspec::Type::VpcEndpoints::STATES.map { |state| "be_#{state.tr('-', '_')}" }
          @describes = []
        end
      end
    end
  end
end
