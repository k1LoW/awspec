module Awspec::Helper
  module Finder
    module Autoscaling
      def find_autoscaling_group(id)
        res = @autoscaling_client.describe_auto_scaling_groups({
                                                                 auto_scaling_group_names: [id]
                                                               })
        res[:auto_scaling_groups].first if res[:auto_scaling_groups].count == 1
      end
    end
  end
end
