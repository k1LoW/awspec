module Awspec::Type
  class Elasticsearch < Base
    def initialize(id)
      super
      @resource_via_client = find_elasticsearch_domain(id)
      @id = @resource_via_client.arn if @resource_via_client
    end

    def has_access_policies?(policy)
      @resource_via_client.access_policies == policy.gsub(/\n/, '').gsub(/ /, '')
    end

    def created?
      @resource_via_client.created
    end

    def deleted?
      @resource_via_client.deleted
    end
  end
end
