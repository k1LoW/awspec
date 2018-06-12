module Awspec::Generator
  module Doc
    module Type
      class Firehose < Base
        def initialize
          super
          @type_name = 'Firehose'
          @type = Awspec::Type::Firehose.new('my-firehose')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
