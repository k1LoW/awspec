module Awspec::Helper
  module Finder
    module Alb
      def find_alb(id)
        res = elbv2_client.describe_load_balancers({ names: [id] })
        res.load_balancers.single_resource(id)
      rescue
        return nil
      end

      def select_alb_by_vpc_id(vpc_id)
        res = elbv2_client.describe_load_balancers
        res.load_balancers.select do |lb|
          lb.vpc_id == vpc_id
        end
      end

      def find_alb_listener(arn)
        res = elbv2_client.describe_listeners({ listener_arns: [arn] })
        res.listeners.single_resource(arn)
      rescue
        return nil
      end

      def find_alb_target_group(id)
        res = elbv2_client.describe_target_groups({ names: [id] })
        res.target_groups.single_resource(id)
      rescue
        return nil
      end

      def select_rule_by_alb_listener_id(id)
        selected = []
        next_marker = nil
        loop do
          res = elbv2_client.describe_rules(marker: next_marker, listener_arn: id)
          selected += res.rules unless res.nil?
          (res.nil? && next_marker = res.next_marker) || break
        end
        selected
      end
    end
  end
end
