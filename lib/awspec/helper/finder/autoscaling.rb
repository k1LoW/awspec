module Awspec::Helper
  module Finder
    module Autoscaling
      def find_autoscaling_group(id)
        res = autoscaling_client.describe_auto_scaling_groups({
                                                                auto_scaling_group_names: [id]
                                                              })
        res[:auto_scaling_groups].single_resource(id)
      end

      def find_launch_configuration(id)
        res = autoscaling_client.describe_launch_configurations({
                                                                  launch_configuration_names: [id]
                                                                })
        res[:launch_configurations].single_resource(id)
      end
    end
  end
end
