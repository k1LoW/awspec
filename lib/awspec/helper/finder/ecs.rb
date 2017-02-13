module Awspec::Helper
  module Finder
    module Ecs
      def find_ecs_cluster(cluster_name)
        res = ecs_client.describe_clusters(clusters: [cluster_name])
        res.clusters.single_resource(cluster_name)
      end

      def select_ecs_container_instance_arns(cluster_name)
        req = { cluster: cluster_name }
        arns = []
        loop do
          res = ecs_client.list_container_instances(req)
          arns.push(*res.container_instance_arns)
          break if res.next_token.nil?
          req[:next_token] = res.next_token
        end
        arns
      end

      def find_ecs_task_definition(taskdef)
        res = ecs_client.describe_task_definition(task_definition: taskdef)
        res.task_definition
      end

      def find_ecs_service(service)
        res = ecs_client.describe_services(services: [service])
        res.services.single_resource(service)
      end

      # deprecated method
      def find_ecs_container_instances(cluster_name, container_instances)
        res = ecs_client.describe_container_instances(cluster: cluster_name, container_instances: container_instances)
        res.container_instances if res.container_instances
      end

      alias_method :list_ecs_container_instances, :select_ecs_container_instance_arns # deprecated method
    end
  end
end
