module Awspec::Type
  class AutoscalingGroup < Base
    def initialize(id)
      super
      @resource = find_autoscaling_group(id)
      @id = @resource[:auto_scaling_group_arn] if @resource
    end

    def has_elb?(name)
      @resource.load_balancer_names.find do |lb_name|
        lb_name == name
      end
    end

    def has_ec2?(id)
      ec2 = find_ec2(id)
      @resource.instances.find do |instance|
        instance.instance_id = ec2.instance_id
      end if ec2
    end
  end
end
