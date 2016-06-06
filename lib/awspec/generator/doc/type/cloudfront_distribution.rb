module Awspec::Generator
  module Doc
    module Type
      class CloudfrontDistribution < Base
        def initialize
          super
          @type_name = 'CloudfrontDistribution'
          @type = Awspec::Type::CloudfrontDistribution.new('123456789zyxw.cloudfront.net')
          @ret = @type.resource_via_client
          @matchers = [
            Awspec::Type::CloudfrontDistribution::STATUSES.map { |status| 'be_' + status.underscore }.join(', ')
          ]

          @ignore_matchers = Awspec::Type::CloudfrontDistribution::STATUSES.map { |status| 'be_' + status.underscore }
          @describes = []
        end
      end
    end
  end
end
