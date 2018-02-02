module Awspec::Type
  class RdsDbClusterParameterGroup < ResourceBase
    def resource_via_client
      return @resource_via_client if @resource_via_client
      @resource_via_client ||= select_all_rds_db_cluster_parameters(@display_name)
    end

    def id
      @id ||= @display_name unless resource_via_client.empty?
    end

    def method_missing(name)
      param_name = name.to_s
      if resource_via_client.include?(param_name)
        resource_via_client[param_name].to_s
      else
        super
      end
    end
  end
end
