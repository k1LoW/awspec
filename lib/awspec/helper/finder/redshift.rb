module Awspec::Helper
  module Finder
    module Redshift
      def find_redshift_cluster_identifier(id)
        res = redshift_client.describe_clusters(cluster_identifier: id)
        res.clusters.single_resource(id)
      rescue
        nil
      end

      def select_redshift_by_vpc_id(vpc_id)
        res = redshift_client.describe_clusters
        res.clusters.select do |clusters|
          clusters.vpc_id == vpc_id
        end
      end

      def select_all_redshift_cluster_parameters(parameter_group)
        parameters = {}
        res = redshift_client.describe_cluster_parameters({
                                                            parameter_group_name: parameter_group
                                                          })
        loop do
          res.parameters.each do |param|
            parameters[param.parameter_name] = param.parameter_value
          end
          break if res.marker.nil?
          res = redshift_client.describe_cluster_parameters({
                                                              parameter_group_name: parameter_group,
                                                              marker: res.marker
                                                            })
        end
        parameters
      end
    end
  end
end
