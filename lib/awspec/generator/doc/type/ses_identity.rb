module Awspec::Generator
  module Doc
    module Type
      class SesIdentity < Base
        def initialize
          super
          @type_name = 'SesIdentity'
          @type = Awspec::Type::SesIdentity.new('my-ses-identity')
          @ret = @type.resource
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
