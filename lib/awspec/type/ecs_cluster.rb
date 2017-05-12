module Awspec::Type
  class EcsCluster < ResourceBase
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

    STATES = %w(ACTIVE INACTIVE)

    STATES.each do |state|
      define_method state.downcase + '?' do
        resource_via_client.status == state
      end
    end

    def has_container_instance?(arn_or_uuid)
      uuid = arn_or_uuid.split('/').last
      find_ecs_container_instance(id, uuid)
    end

    # deprecated method
    def container_instance_arns
      puts ''
      warn Color.on_red(Color.white("!!! `#{__method__}` is deprecated. awspec don't provide complex result !!!"))
      @container_instance_arns ||= select_ecs_container_instance_arn_by_cluster_name(id)
    end

    # deprecated method
    def container_instances
      puts ''
      warn Color.on_red(Color.white("!!! `#{__method__}` is deprecated. awspec don't provide complex result !!!"))
      return @container_instances if @container_instances
      arns = container_instance_arns
      @container_instances ||=
        arns.empty? ? [] : find_ecs_container_instances(id, arns).map! { |ci| EcsContainerInstance.new(id, ci) }
    end
  end
end
