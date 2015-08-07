module Awspec::Type
  class AutoScalingGroup < Base
    attr_reader :group

    def initialize(id)
      super
      @group = find_auto_scaling_group(id)
      @id = @group[:auto_scaling_group_arn] if @group
    end

    def has_elb?(name)
      @group.load_balancer_names.find do |lb_name|
        lb_name == name
      end
    end

    def has_ec2?(id)
      ec2 = find_ec2(id)
      @group.instances.find do |instance|
        instance.instance_id = ec2.instance_id
      end if ec2
    end

    def method_missing(name)
      describe = name.to_sym
      if @group.members.include?(describe)
        @group[describe]
      else
        super
      end
    end
  end
end
