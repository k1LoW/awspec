module Awspec::Type
  class CodedeployDeploymentGroup < ResourceBase
    attr_accessor :application_name

    def initialize(group)
      super
      @display_name = group
    end

    def resource_via_client
      @resource_via_client ||= find_codedeploy_deployment_group(application_name, @display_name)
    end

    def id
      @id ||= resource_via_client.deployment_group_id if resource_via_client
    end

    def application_name
      @application_name || 'default'
    end

    def has_autoscaling_group?(asg_name)
      asgs = resource_via_client.auto_scaling_groups
      res = asgs.find do |asg|
        asg.name == asg_name
      end
      return true if res
      asg2 = find_autoscaling_group(asg_name)
      return true if asgs.include? asg2.auto_scaling_group_name
      false
    end
  end
end
