module Awspec::Type
  class CloudfrontDistribution < Base
    def initialize(id)
      super
      @resource_via_client = find_cloudfront_distribution(id)
      @id = @resource_via_client.id if @resource_via_client
    end
  end
end
