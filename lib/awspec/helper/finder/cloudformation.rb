module Awspec::Helper
  module Finder
    module Cloudformation
      def find_cloudformation_stack(id)
        res = cloudformation_client.describe_stacks({
                                                      stack_name: id
                                                    })
        res.stacks.single_resource(id)
      end
    end
  end
end
