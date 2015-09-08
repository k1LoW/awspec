module Awspec::Helper
  module Finder
    module AutoScaling
      def find_auto_scaling_group(id)
        res = @auto_scaling_client.describe_auto_scaling_groups({
                                                                  auto_scaling_group_names: [id]
                                                                })
        res[:auto_scaling_groups].first if res[:auto_scaling_groups].count == 1
      end
    end
  end
end
