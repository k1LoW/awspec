# frozen_string_literal: true

module Awspec::Helper
  module Finder
    module Eip
      def select_eip_by_instance_id(id)
        res = ec2_client.describe_addresses({
                                              filters: [{ name: 'instance-id', values: [id] }]
                                            })
        res.addresses
      end

      def select_eip(id)
        res = ec2_client.describe_addresses({
                                              filters: [{ name: 'public-ip', values: [id] }]
                                            })
        return res.addresses.single_resource(id) unless res.addresses.empty?

        res = ec2_client.describe_addresses({
                                              filters: [{ name: 'tag:Name', values: [id] }]
                                            })
        res.addresses.single_resource(id)
      end
    end
  end
end
