module Awspec::Helper
  module Finder
    module Alb
      def find_alb(id)
        res = elbv2_client.describe_load_balancers({names: [id] })
        res.load_balancers.first
      rescue
        return nil
      end

      def select_alb_by_vpc_id(vpc_id)
        res = elbv2_client.describe_load_balancers
        res.load_balancer_descriptions.select do |lb|
          lb.vpc_id == vpc_id
        end
      end
    end
  end
end
