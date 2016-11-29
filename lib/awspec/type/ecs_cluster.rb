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

    def active?
      resource_via_client.status == 'ACTIVE'
    end

    def inactive?
      resource_via_client.status == 'INACTIVE'
    end

    def container_instance_arns
      @container_instance_arns ||= list_ecs_container_instances(id)
    end

    def container_instances
      return @container_instances if @container_instances
      arns = container_instance_arns
      @container_instances ||=
        arns.empty? ? [] : find_ecs_container_instances(id, arns).map! { |ci| EcsContainerInstance.new(id, ci) }
    end
  end
end
