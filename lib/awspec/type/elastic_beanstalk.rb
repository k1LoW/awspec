module Awspec::Type
  class ElasticBeanstalk < ResourceBase
    def initialize(name)
      super
      @display_name = name
    end

    def resource_via_client
      @resource_via_client ||= find_eb_environment(@display_name)
    end

    def id
      @id ||= resource_via_client.environment_id if resource_via_client
    end
  end
end
