# frozen_string_literal: true

module Awspec::Generator
  module Doc
    module Type
      class EcrRepository < Base
        def initialize
          super
          @type_name = 'ECR Repository'
          @type = Awspec::Type::EcrRepository.new('my-ecr-repository')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
