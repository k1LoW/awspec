module Awspec::Helper
  module Finder
    module Codedeploy
      def find_codedeploy_app(name)
        res = codedeploy_client.get_application(application_name: name)
        res.application
      end

      def find_codedeploy_deployment_group(application, group)
        res = codedeploy_client.get_deployment_group(application_name: application, deployment_group_name: group)
        res.deployment_group_info
      end
    end
  end
end
