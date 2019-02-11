module Awspec::Generator
  module Doc
    module Type
      class CodedeployDeploymentGroup < Base
        def initialize
          super
          @type_name = 'CodedeployDeploymentGroup'
          @type = Awspec::Type::CodedeployDeploymentGroup.new('my-codedeploy-deployment-group')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
