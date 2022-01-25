# frozen_string_literal: true

module Awspec::Helper
  module States
    EC2_STATES = %w(pending running shutting-down terminated stopping stopped).freeze

    def self.ec2_states_checks
      Enumerator.new do |yielder|
        n = 0
        while n < EC2_STATES.size
          method_name = EC2_STATES[n].tr('-', '_') + '?'
          yielder.yield(method_name, EC2_STATES[n])
          n += 1
        end
      end.lazy
    end
  end
end
