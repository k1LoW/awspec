module Awspec::Helper
  module Finder
    module Ec2
      def find_ec2(id)
        if id.is_a?(Array)
          # Aws::EC2::Client.describe_instances native filters format
          res = @ec2_client.describe_instances({
                                                 filters: id
                                               })
        elsif id.is_a?(Hash)
          # syntax sugar
          filters = []
          id.each do |k, v|
            filters.push({ name: k, values: Array(v) })
          end
          res = @ec2_client.describe_instances({
                                                 filters: filters
                                               })
        elsif id.is_a?(String)
          # instance_id or tag:Name
          begin
            res = @ec2_client.describe_instances({
                                                   instance_ids: [id]
                                                 })
          rescue
            # Aws::EC2::Errors::InvalidInstanceIDMalformed
            # Aws::EC2::Errors::InvalidInstanceIDNotFound
            res = @ec2_client.describe_instances({
                                                   filters: [{ name: 'tag:Name', values: [id] }]
                                                 })
          end
        else
          return nil
        end
        return res[:reservations].first[:instances].first if res[:reservations].count == 1 && \
                                                             res[:reservations].first[:instances].count == 1
      end

      def find_ec2_attribute(id, attribute)
        res = @ec2_client.describe_instance_attribute({
                                                        instance_id: id, attribute: attribute
                                                      })
      end

      # fine_internet_gateway fine_vpn_gateway fine_customer_gateway
      gateway_types = %w(internet vpn cutromer)
      gateway_types.each do |type|
        define_method 'find_' + type + '_gateway' do |*args|
          gateway_id = args.first
          res = @ec2_client.method('describe_' + type + '_gateways').call({
                                                                            filters: [
                                                                              {
                                                                                name: type + '-gateway-id',
                                                                                values: [gateway_id]
                                                                              }
                                                                            ]
                                                                          })
          return res[type + '_gateways'].first if res[type + '_gateways'].count == 1
          res = @ec2_client.method('describe_' + type + '_gateways').call({
                                                                            filters: [
                                                                              {
                                                                                name: 'tag:Name',
                                                                                values: [gateway_id]
                                                                              }
                                                                            ]
                                                                          })
          return res[type + '_gateways'].first if res[type + '_gateways'].count == 1
        end
      end

      def find_security_group(sg_id)
        res = @ec2_client.describe_security_groups({
                                                     filters: [{ name: 'group-id', values: [sg_id] }]
                                                   })
        return res[:security_groups].first if res[:security_groups].count == 1
        res = @ec2_client.describe_security_groups({
                                                     filters: [{ name: 'group-name', values: [sg_id] }]
                                                   })
        return res[:security_groups].first if res[:security_groups].count == 1
        res = @ec2_client.describe_security_groups({
                                                     filters: [{ name: 'tag:Name', values: [sg_id] }]
                                                   })
        return res[:security_groups].first if res[:security_groups].count == 1
      end

      def select_ec2_by_vpc_id(vpc_id)
        res = @ec2_client.describe_instances({
                                               filters: [{ name: 'vpc-id', values: [vpc_id] }]
                                             })
        instances = []
        return instances unless res[:reservations].count > 0
        res[:reservations].each do |reservation|
          reservation.instances.each do |instance|
            instances.push(instance)
          end
        end
        instances
      end

      def select_eip_by_instance_id(id)
        res = @ec2_client.describe_addresses({
                                               filters: [{ name: 'instance-id', values: [id] }]
                                             })
        return [] unless res[:addresses].count > 0
        res[:addresses]
      end
    end
  end
end
