module Awspec::Helper
  module Finder
    module Rds
      def find_rds(id)
        begin
          res = rds_client.describe_db_instances({
                                                   db_instance_identifier: id
                                                 })
        rescue
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
          (res.next_page? && res = res.next_page) || break
        end
        parameters
      end

      def select_all_rds_db_cluster_parameters(parameter_group)
        parameters = {}
        res = rds_client.describe_db_cluster_parameters({
                                                          db_cluster_parameter_group_name: parameter_group
                                                        })
        loop do
          res.parameters.each do |param|
            parameters[param.parameter_name] = param.parameter_value
          end
          (res.respond_to?(:next_page?) && res.next_page? && res = res.next_page) || break
        end
        parameters
      end
    end
  end
end
