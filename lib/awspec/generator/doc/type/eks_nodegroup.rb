# frozen_string_literal: true

module Awspec::Generator
  module Doc
    module Type
      class EksNodegroup < Base
        def initialize
          super
          @type_name = 'EksNodegroup'
          @type = Awspec::Type::EksNodegroup.new('my-eks-nodegroup')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::EksNodegroup::STATES.map { |state| "be_#{state.downcase}" }.join(', ')
          ]
          @ignore_matchers = Awspec::Type::EksNodegroup::STATES.map { |state| "be_#{state.downcase}" }
          @describes = []
        end
      end
    end
  end
end
