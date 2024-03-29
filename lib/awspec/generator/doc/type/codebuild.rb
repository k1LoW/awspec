# frozen_string_literal: true

module Awspec::Generator
  module Doc
    module Type
      class Codebuild < Base
        def initialize
          super
          @type_name = 'Codebuild'
          @type = Awspec::Type::Codebuild.new('my-codebuild')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
