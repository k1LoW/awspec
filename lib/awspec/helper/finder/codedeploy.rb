module Awspec::Helper
  module Finder
    module Codedeploy
      def find_codedeploy_app(name)
        res = codedeploy_client.get_application(application_name: name)
        res.application
      end
    end
  end
end
