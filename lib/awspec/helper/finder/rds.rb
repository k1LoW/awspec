# frozen_string_literal: true

module Awspec::Helper
  module Finder
    module Rds
      def find_rds(id)
        begin
          res = rds_client.describe_db_instances({
                                                   db_instance_identifier: id
                                                 })
        rescue StandardError
          res = rds_client.describe_db_instances({
                                                   filters: [{ name: 'db-instance-id', values: [id] }]
                                                 })
        end
        res.db_instances.single_resource(id)
      end

      def select_rds_by_vpc_id(vpc_id)
        res = rds_client.describe_db_instances
        res.db_instances.select do |db_instance|
          db_instance.db_subnet_group.vpc_id == vpc_id
        end
      end

      def select_all_rds_db_parameters(parameter_group)
        parameters = {}
        res = rds_client.describe_db_parameters({
                                                  db_parameter_group_name: parameter_group
                                                })
        loop do
          res.parameters.each do |param|
            parameters[param.parameter_name] = param.parameter_value
          end
          break if res.marker.nil?

          res = rds_client.describe_db_parameters({
                                                    db_parameter_group_name: parameter_group,
                                                    marker: res.marker
                                                  })
        end
        parameters
      end

      def select_all_rds_db_cluster_parameters(parameter_group)
        parameters = {}
        next_marker = nil
        loop do
          res = rds_client.describe_db_cluster_parameters({
                                                            marker: next_marker,
                                                            db_cluster_parameter_group_name: parameter_group
                                                          })
          res.parameters.each do |param|
            parameters[param.parameter_name] = param.parameter_value
          end
          (res.marker.present? && next_marker = res.marker) || break
        end
        parameters
      end

      def find_rds_proxy(db_proxy_name)
        res = rds_client.describe_db_proxies({
                                               db_proxy_name: db_proxy_name
                                             })
        res.db_proxies.single_resource(db_proxy_name)
      end

      def select_rds_proxy_by_vpc_id(vpc_id)
        res = rds_client.describe_db_proxies
        res.db_proxies.select do |db_proxy|
          db_proxy.vpc_id == vpc_id
        end
      end

      def find_db_cluster(db_cluster_identifier)
        res = rds_client.describe_db_clusters({
                                                db_cluster_identifier: db_cluster_identifier
                                              })
        res.db_clusters.single_resource(db_cluster_identifier)
      end

      def find_global_cluster(global_cluster_identifier)
        res = rds_client.describe_global_clusters({
                                                    global_cluster_identifier: global_cluster_identifier
                                                  })
        res.global_clusters.single_resource(global_cluster_identifier)
      end

      def find_db_subnet_group(db_subnet_group_name)
        res = rds_client.describe_db_subnet_groups({
                                                     db_subnet_group_name: db_subnet_group_name
                                                   })
        res.db_subnet_groups.single_resource(db_subnet_group_name)
      end
    end
  end
end
