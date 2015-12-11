module Awspec::Generator
  module Doc
    module Type
      class SesIdentity < Base
        def initialize
          super
          @type_name = 'SesIdentity'
          @type = Awspec::Type::SesIdentity.new('example.com')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = %w(
            dkim_enabled dkim_verification_status
            bounce_topic complaint_topic delivery_topic
            forwarding_enabled
            verification_status verification_token
          )
        end
      end
    end
  end
end
