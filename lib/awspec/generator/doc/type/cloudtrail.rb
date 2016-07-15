module Awspec::Generator
  module Doc
    module Type
      class Cloudtrail < Base
        def initialize
          super
          @type_name = 'Cloudtrail'
          @type = Awspec::Type::Cloudtrail.new('my-trail')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
