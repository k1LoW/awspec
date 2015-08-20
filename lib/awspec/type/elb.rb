module Awspec::Type
  class Elb < Base
    attr_reader :lb

    def initialize(id)
      super
      @lb = find_elb(id)
      @id = @lb[:load_balancer_name] if @lb
    end

    health_check_options = %w(
      target interval timeout
      unhealthy_threshold healthy_threshold
    )

    health_check_options.each do |option|
      define_method 'health_check_' + option do
        @lb[:health_check][option]
      end
    end

    def method_missing(name)
      describe = name.to_sym
      if @lb.members.include?(describe)
        @lb[describe]
      else
        super
      end
    end

    def has_ec2?(id)
      ec2 = find_ec2(id)
      @lb.instances.find do |instance|
        instance.instance_id = ec2.instance_id
      end if ec2
    end

    def has_security_group?(sg_id)
      sgs = @lb[:security_groups]
      ret = sgs.find do |sg|
        sg == sg_id
      end
      return true if ret
      sg2 = find_security_group(sg_id)
      return false unless sg2.tag_name == sg_id || sg2[:group_name] == sg_id
      sgs.find do |sg|
        sg == sg2[:group_name]
      end
    end

    def has_subnet?(subnet_id)
      subnets = @lb[:subnets]
      ret = subnets.find do |s|
        s == subnet_id
      end
      return true if ret
      res = find_subnet(subnet_id)
      ret = subnets.find do |s|
        s == res[:subnet_id]
      end
    end

    def has_listener?(protocol:, port:, instance_protocol:, instance_port:)
      @lb[:listener_descriptions].find do |desc|
        listener = desc.listener
        listener.protocol == protocol && listener.load_balancer_port == port && \
          listener.instance_protocol == instance_protocol && listener.instance_port == instance_port
      end
    end
  end
end
