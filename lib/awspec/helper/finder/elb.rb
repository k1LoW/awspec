module Awspec::Helper
  module Finder
    module Elb
      def find_elb(id)
        res = elb_client.describe_load_balancers({
                                                   load_balancer_names: [id]
                                                 })
        res.load_balancer_descriptions.single_resource(id)
      rescue
        return nil
      end

      def find_elb_attribute(id)
        res = elb_client.describe_load_balancer_attributes({
                                                             load_balancer_name: id
                                                           })
        res.load_balancer_attributes
      rescue
        return nil
      end

      def select_elb_by_vpc_id(vpc_id)
        res = elb_client.describe_load_balancers
        res.load_balancer_descriptions.select do |lb|
          lb.vpc_id == vpc_id
        end
      end

      def select_all_elb_tags(id)
        res = elb_client.describe_tags({
                                         load_balancer_names: [id]
                                       })
        res.tag_descriptions.single_resource(id).tags
      end
    end
  end
end
