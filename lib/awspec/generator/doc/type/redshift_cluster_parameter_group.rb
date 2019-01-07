module Awspec::Generator
  module Doc
    module Type
      class RedshiftClusterParameterGroup < Base
        def initialize
          super
          @type_name = 'RedshiftClusterParameterGroup'
          @type = Awspec::Type::RedshiftClusterParameterGroup.new('my-redshift-cluster-parameter-group')
          @ret = @type.resource_via_client
          @matchers = []
          @ignore_matchers = []
          @describes = []
        end
      end
    end
  end
end
