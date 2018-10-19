module Awspec::Helper
  module Finder
    module ElasticBeanstalk
      def find_eb_environment(name)
        res = elastic_beanstalk_client
          .describe_environments({
                                   environment_names: [ name ]
                                 })
        res.environments.single_resource(name)
      rescue
        return nil
      end
    end
  end
end
