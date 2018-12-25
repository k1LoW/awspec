module Awspec::Helper
  module Finder
    module Nlb
      def find_nlb(id)
        res = elbv2_client.describe_load_balancers({ names: [id] })
        res.load_balancers.select do |lb|
          lb.type == 'network'
        end.single_resource(id)
      rescue
        return nil
      end

      def select_nlb_by_vpc_id(vpc_id)
        res = elbv2_client.describe_load_balancers
        res.load_balancers.select do |lb|
          lb.vpc_id == vpc_id && lb.type == 'network'
        end
      end

      def find_nlb_listener(arn)
        res = elbv2_client.describe_listeners({ listener_arns: [arn] })
        res.listeners.single_resource(arn)
      rescue
        return nil
      end

      def select_nlb_listener_by_nlb_arn(arn)
        selected = []
        next_marker = nil
        loop do
          res = elbv2_client.describe_listeners({ marker: next_marker, load_balancer_arn: arn })
          selected += res.listeners unless res.nil?
          (res.nil? && next_marker = res.next_marker) || break
        end
        selected
      end

      def find_nlb_target_group(id)
        res = elbv2_client.describe_target_groups({ names: [id] })
        httpx_res = res.target_groups.select do |tg|
          %w(HTTP HTTPS).include?(tg.protocol)
        end
        if !httpx_res || httpx_res.empty?
          raise "ERROR: Found no HTTP nor HTTPS -protocol target group named '#{id}'."
        end
        httpx_res.single_resource(id)
      rescue
        # Prefer the HTTP/HTTPS protocol target group, but survive without it:
        begin
          res.target_groups.single_resource(id)
        rescue
          return nil
        end
      end

      def select_rule_by_nlb_listener_id(id)
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
