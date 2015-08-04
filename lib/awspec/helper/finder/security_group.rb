module Awspec::Helper
  module Finder
    module SecurityGroup
      def find_security_group(id)
        res = @ec2_client.describe_security_groups({
                                                     filters: [{ name: 'group-id', values: [id] }]
                                                   })

        return res[:security_groups][0] if res[:security_groups].count == 1
        res = @ec2_client.describe_security_groups({
                                                     filters: [{ name: 'group-name', values: [id] }]
                                                   })

        return res[:security_groups][0] if res[:security_groups].count == 1
        res = @ec2_client.describe_security_groups({
                                                     filters: [{ name: 'tag:Name', values: [id] }]
                                                   })

        return res[:security_groups][0] if res[:security_groups].count == 1
      end
    end
  end
end
