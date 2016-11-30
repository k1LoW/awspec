module Awspec::Type
  class AutoscalingGroup < Base
    aws_resource Aws::AutoScaling::AutoScalingGroup
    tags_allowed

    def resource_via_client
      @resource_via_client ||= find_autoscaling_group(@display_name)
    end

    def id
      @id ||= resource_via_client.auto_scaling_group_arn if resource_via_client
    end

    def has_elb?(name)
      resource_via_client.load_balancer_names.find do |lb_name|
        lb_name == name
      end
    end

    def has_ec2?(id)
      ec2 = find_ec2(id)
      resource_via_client.instances.find do |instance|
        instance.instance_id = ec2.instance_id
      end if ec2
    end
  end
end
