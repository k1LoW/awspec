module Awspec::Type
  class EcsCluster < Base
    aws_resource Aws::ECS::Types::Cluster

    def initialize(name)
      super
      @display_name = name
    end
    
    def resource_via_client
      return @resource_via_client if @resource_via_client

      parameters = {}
      res = ecs_client.describe_clusters({ clusters: [@display_name] })

      @resource_via_client = res.clusters.first
    end

    def id
      @id ||= resource_via_client.cluster_name if resource_via_client
    end

  end
end
