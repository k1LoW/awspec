module Awspec::Type
  class EcsCluster < Base
    aws_resource Aws::ECS::Types::Cluster

    def initialize(name)
      super
      @display_name = name
    end
    
    def resource_via_client
      @resource_via_client ||= find_ecs_cluster(@display_name)
    end

    def id
      @id ||= resource_via_client.cluster_name if resource_via_client
    end
  end
end
