module Awspec::Type
  class AutoscalingGroup < ResourceBase
    aws_resource Aws::AutoScaling::AutoScalingGroup
    tags_allowed

    def resource_via_client
      @resource_via_client ||= find_autoscaling_group(@display_name)
    end

    def id
      @id ||= resource_via_client.auto_scaling_group_arn if resource_via_client
    end

    def has_elb?(name)
      resource_via_client.load_balancer_names.one? do |lb_name|
        lb_name == name
      end
    end

    def has_ec2?(id)
      ec2 = find_ec2(id)
      return nil unless ec2
      resource_via_client.instances.one? do |instance|
        instance.instance_id = ec2.instance_id
      end
    end

    def has_suspended_process?(id)
      resource_via_client.suspended_processes.one? do |process|
        process.process_name == id
      end
    end
  end
end
