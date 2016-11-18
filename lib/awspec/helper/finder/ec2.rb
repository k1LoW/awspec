module Awspec::Helper
  module Finder
    module Ec2
      def find_ec2(id)
        # instance_id or tag:Name
        begin
          res = ec2_client.describe_instances({
                                                instance_ids: [id]
                                              })
        rescue
          # Aws::EC2::Errors::InvalidInstanceIDMalformed
          # Aws::EC2::Errors::InvalidInstanceIDNotFound
          res = ec2_client.describe_instances({
                                                filters: [{ name: 'tag:Name', values: [id] }]
                                              })
        end
        # rubocop:enable Style/GuardClause
        res.reservations.first.instances.single_resource(id) if res.reservations.count == 1
      end

      def find_ec2_attribute(id, attribute)
        res = ec2_client.describe_instance_attribute({
                                                       instance_id: id, attribute: attribute
                                                     })
      end

      def find_ec2_status(id)
        res = ec2_client.describe_instance_status({
                                                    instance_ids: [id]
                                                  })
        res.instance_statuses.first if res.instance_statuses.count == 1
      end

      # find_internet_gateway find_vpn_gateway find_customer_gateway
      gateway_types = %w(internet vpn customer)
      gateway_types.each do |type|
        define_method 'find_' + type + '_gateway' do |*args|
          gateway_id = args.first
          method_name = 'describe_' + type + '_gateways'
          res = ec2_client.method(method_name).call({
                                                      filters: [{ name: type + '-gateway-id', values: [gateway_id] }]
                                                    })
          resource = res[type + '_gateways'].single_resource(gateway_id)
          return resource if resource
          res = ec2_client.method(method_name).call({
                                                      filters: [{ name: 'tag:Name', values: [gateway_id] }]
                                                    })
          res[type + '_gateways'].single_resource(gateway_id)
        end
      end

      def find_vpn_connection(vpn_connection_id)
        res = ec2_client.describe_vpn_connections({
                                                    filters: [
                                                      {
                                                        name: 'vpn-connection-id',
                                                        values: [vpn_connection_id]
                                                      }
                                                    ]
                                                  })
        res.vpn_connections.single_resource(vpn_connection_id)
      end

      def find_nat_gateway(gateway_id)
        res = ec2_client.describe_nat_gateways({
                                                 filter: [{ name: 'nat-gateway-id', values: [gateway_id] }]
                                               })
        res.nat_gateways.single_resource(gateway_id)
      end

      def find_network_interface(interface_id)
        res = ec2_client.describe_network_interfaces({
                                                       filters: [
                                                         {
                                                           name: 'network-interface-id',
                                                           values: [interface_id]
                                                         }
                                                       ]
                                                     })
        resource = res.network_interfaces.single_resource(interface_id)
        return resource if resource
        res = ec2_client.describe_network_interfaces({
                                                       filters: [{ name: 'tag:Name', values: [interface_id] }]
                                                     })
        res.network_interfaces.single_resource(interface_id)
      end

      def select_ec2_by_vpc_id(vpc_id)
        res = ec2_client.describe_instances({
                                              filters: [{ name: 'vpc-id', values: [vpc_id] }]
                                            })
        instances = []
        res.reservations.each do |reservation|
          reservation.instances.each do |instance|
            instances.push(instance)
          end
        end
        instances
      end

      def select_eip_by_instance_id(id)
        res = ec2_client.describe_addresses({
                                              filters: [{ name: 'instance-id', values: [id] }]
                                            })
        res.addresses
      end

      def select_nat_gateway_by_vpc_id(vpc_id)
        res = ec2_client.describe_nat_gateways({
                                                 filter: [{ name: 'vpc-id', values: [vpc_id] }]
                                               })
        res.nat_gateways
      end

      def select_network_interface_by_vpc_id(vpc_id)
        res = ec2_client.describe_network_interfaces({
                                                       filters: [{ name: 'vpc-id', values: [vpc_id] }]
                                                     })
        res.network_interfaces
      end
    end
  end
end
