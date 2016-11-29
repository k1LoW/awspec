module Awspec::Helper
  module Finder
    module Ecs
      def find_ecs_cluster(cluster_name)
        res = ecs_client.describe_clusters(clusters: [cluster_name])
        res.clusters.first if res.clusters.count == 1
      end

      def list_ecs_container_instances(cluster_name)
        req = { cluster: cluster_name }
        container_instances = []
        loop do
          res = ecs_client.list_container_instances(req)
          container_instances.push(*res.container_instance_arns)
          break if res.next_token.nil?
          req[:next_token] = res.next_token
        end
        container_instances
      end

      def find_ecs_container_instances(cluster_name, container_instances)
        res = ecs_client.describe_container_instances(cluster: cluster_name, container_instances: container_instances)
        res.container_instances if res.container_instances
      end

      def find_ecs_task_definition(taskdef)
        res = ecs_client.describe_task_definition(task_definition: taskdef)
        res.task_definition
      end

      def find_ecs_service(service)
        res = ecs_client.describe_services(services: [service])
        res.services.first if res.services.count == 1
      end
    end
  end
end
