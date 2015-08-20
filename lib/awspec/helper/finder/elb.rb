module Awspec::Helper
  module Finder
    module Elb
      def find_elb(id)
        res = @elb_client.describe_load_balancers({
                                                    load_balancer_names: [id]
                                                  })
        return res[:load_balancer_descriptions][0] if res[:load_balancer_descriptions].count == 1
      rescue
        return nil
      end
    end
  end
end
