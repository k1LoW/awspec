# frozen_string_literal: true

module Awspec::Generator
  module Doc
    module Type
      class Codepipeline < Base
        def initialize
          super
          @type_name = 'Codepipeline'
          @type = Awspec::Type::Codepipeline.new('my-codepipeline')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
