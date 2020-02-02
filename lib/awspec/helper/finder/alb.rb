module Awspec::Helper
  module Finder
    module Alb
      def find_alb(id)
        res = elbv2_client.describe_load_balancers({ names: [id] })
        res.load_balancers.select do |lb|
          lb.type == 'application'
        end.single_resource(id)
      rescue Aws::ElasticLoadBalancingV2::Errors::LoadBalancerNotFound
        return nil
      end

      def select_alb_by_vpc_id(vpc_id)
        res = elbv2_client.describe_load_balancers
        res.load_balancers.select do |lb|
          lb.vpc_id == vpc_id && lb.type == 'application'
        end
      end

      def find_alb_listener(arn)
        res = elbv2_client.describe_listeners({ listener_arns: [arn] })
        res.listeners.single_resource(arn)
      rescue StandardError
        return nil
      end

      def select_alb_listener_by_alb_arn(arn)
        selected = []
        next_marker = nil
        loop do
          res = elbv2_client.describe_listeners({ marker: next_marker, load_balancer_arn: arn })
          selected += res.listeners unless res.nil?
          (res.nil? && next_marker = res.next_marker) || break
        end
        selected
      end

      def find_alb_target_group(id)
        res = elbv2_client.describe_target_groups({ names: [id] })
        res.target_groups.select do |tg|
          %w(HTTP HTTPS).include?(tg.protocol)
        end.single_resource(id)
      rescue StandardError
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

      def select_all_alb_tags(id)
        res = elbv2_client.describe_tags({ resource_arns: [id] })
        res.tag_descriptions.select do |resource|
          resource.resource_arn == id
        end.first.tags
      rescue StandardError
        return nil
      end
    end
  end
end
