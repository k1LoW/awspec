module Awspec::Helper
  module Finder
    module Autoscaling
      def find_autoscaling_group(id)
        res = autoscaling_client.describe_auto_scaling_groups({
                                                                auto_scaling_group_names: [id]
                                                              })
        res.auto_scaling_groups.single_resource(id)
      end

      def find_launch_configuration(id)
        res = autoscaling_client.describe_launch_configurations({
                                                                  launch_configuration_names: [id]
                                                                })
        res.launch_configurations.single_resource(id)
      end

      def select_alb_target_group_by_autoscaling_group_name(name)
        res = autoscaling_client.describe_load_balancer_target_groups({
                                                                        auto_scaling_group_name: name
                                                                      })
        res.load_balancer_target_groups
      end

      def select_lb_target_group_by_autoscaling_group_name(name)
        res = autoscaling_client.describe_load_balancer_target_groups({
                                                                        auto_scaling_group_name: name
                                                                      })
        res.load_balancer_target_groups
      end

      def find_block_device_mapping(id, device_id)
        ret = find_launch_configuration(id).block_device_mappings.select do |device|
          next true if device.device_name == device_id
          next true if device.virtual_name == device_id
        end
        ret.single_resource(device_id)
      end

      def select_autoscaling_group_by_vpc_id(vpc_id)
        subnets = []
        select_subnet_by_vpc_id(vpc_id).each { |subnet| subnets << subnet.subnet_id }
        req = {}
        selected = []
        loop do
          res = autoscaling_client.describe_auto_scaling_groups(req)
          res.auto_scaling_groups.select do |auto_scaling_group|
            vpc_zone_identifiers = auto_scaling_group.vpc_zone_identifier.split(',')
            selected.push(auto_scaling_group) if vpc_zone_identifiers.any? do |vpc_zone_identifier|
              subnets.include?(vpc_zone_identifier)
            end
          end
          break if res.next_token.nil?
          req[:next_token] = res.next_token
        end
        selected
      end
    end
  end
end
