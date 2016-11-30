module Awspec::Generator
  module Doc
    module Type
      class EcrRepository < Base
        def initialize
          super
          @type = Awspec::Type::EcrRepository.new('my-ecr-repository')
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
