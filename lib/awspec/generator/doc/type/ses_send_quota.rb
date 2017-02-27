module Awspec::Generator
  module Doc
    module Type
      class SesSendQuota < Base
        def initialize
          super
          @type_name = 'SesSendQuota'
          @type = Awspec::Type::SesSendQuota.new('my-ses-send-quota')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
