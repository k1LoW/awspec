module Awspec::Helper
  module Finder
    module Ecs
      def find_ecs_cluster(cluster)
        res = ecs_client.describe_clusters(clusters: [cluster])
        res.clusters.single_resource(cluster)
      end

      def find_ecs_container_instance(cluster, uuid)
        res = ecs_client.describe_container_instances(cluster: cluster, container_instances: [uuid])
        res.container_instances.single_resource(uuid)
      end

      def find_ecs_task_definition(taskdef)
        res = ecs_client.describe_task_definition(task_definition: taskdef)
        res.task_definition
      end

      def find_ecs_service(cluster, service)
        res = ecs_client.describe_services(cluster: cluster, services: [service])
        res.services.single_resource(service)
      end

      def select_ecs_container_instance_arn_by_cluster_name(cluster)
        req = { cluster: cluster }
        arns = []
        loop do
          res = ecs_client.list_container_instances(req)
          arns.push(*res.container_instance_arns)
          break if res.next_token.nil?
          req[:next_token] = res.next_token
        end
        arns
      end

      # deprecated method
      def find_ecs_container_instances(cluster, container_instances)
        res = ecs_client.describe_container_instances(cluster: cluster, container_instances: container_instances)
        res.container_instances if res.container_instances
      end

      alias_method :list_ecs_container_instances, :select_ecs_container_instance_arn_by_cluster_name # deprecated method
    end
  end
end
