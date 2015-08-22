module Awspec::Generator
  module Doc
    module Type
      class Route53HostedZone < Base
        def initialize
          super
          @type = Awspec::Type::Route53HostedZone.new('example.com.')
          @ret = @type.hosted_zone
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
