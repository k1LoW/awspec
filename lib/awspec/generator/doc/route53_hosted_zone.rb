module Awspec::Generator
  module Doc
    class Route53HostedZone < Base
      def initialize
        @type_name = 'Route53HostedZone'
        require File.dirname(__FILE__) + '/../../../../spec/stub/' + @type_name.to_snake_case
        @type = Awspec::Type::Route53HostedZone.new('example.com.')
        @ret = @type.hosted_zone
        @matchers = []
        @ignore_matchers = []
        @describes = []
      end
    end
  end
end
