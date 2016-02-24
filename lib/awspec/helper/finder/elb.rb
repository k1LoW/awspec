module Awspec::Helper
  module Finder
    module Elb
      def find_elb(id)
        res = elb_client.describe_load_balancers({
                                                   load_balancer_names: [id]
                                                 })
        res[:load_balancer_descriptions].single_resource(id)
      rescue
        return nil
      end

      def select_elb_by_vpc_id(vpc_id)
        res = elb_client.describe_load_balancers
        res[:load_balancer_descriptions].select do |lb|
          lb.vpc_id == vpc_id
        end
      end
    end
  end
end
