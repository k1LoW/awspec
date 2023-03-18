# frozen_string_literal: true

RSpec::Matchers.define :belong_to_subnet do |subnet_id|
  match do |type|
    # EC2, NetworkInterface
    if type.instance_of?(Awspec::Type::Ec2) || type.instance_of?(Awspec::Type::NetworkInterface)
      return true if type.subnet_id == subnet_id

      subnet = type.find_subnet(subnet_id)
      return false unless subnet

      return subnet[:subnet_id] == type.subnet_id
    end

    # RDS
    if type.instance_of?(Awspec::Type::Rds)
      subnets = type.resource_via_client[:db_subnet_group][:subnets]
      ret = subnets.find do |s|
        s[:subnet_identifier] == subnet_id
      end

      return ret[:subnet_availability_zone][:name] == type.availability_zone if ret

      res = type.ec2_client.describe_subnets({
                                               filters: [{ name: 'tag:Name', values: [subnet_id] }]
                                             })
      return false unless res

      ret = subnets.find do |s|
        s[:subnet_identifier] == res[:subnets][0][:subnet_id]
      end

      return ret[:subnet_availability_zone][:name] == type.availability_zone if ret
    end

    # RDS DB Subnet Group
    if type.instance_of?(Awspec::Type::RdsDbSubnetGroup)
      subnets = type.resource_via_client[:subnets]
      ret = subnets.find do |s|
        s[:subnet_identifier] == subnet_id
      end

      return true if ret

      res = type.ec2_client.describe_subnets({
                                               filters: [{ name: 'tag:Name', values: [subnet_id] }]
                                             })
      return false unless res

      ret = subnets.find do |s|
        s[:subnet_identifier] == res[:subnets][0][:subnet_id]
      end

      return ret ? true : false
    end

    # RDS Proxy
    if type.instance_of?(Awspec::Type::RdsProxy)
      subnet_ids = type.resource_via_client[:vpc_subnet_ids]
      return true if subnet_ids.include?(subnet_id)

      res = type.ec2_client.describe_subnets({
                                               filters: [{ name: 'tag:Name', values: [subnet_id] }]
                                             })
      return false unless res

      ret = subnet_ids.find do |s|
        s == res[:subnets][0][:subnet_id]
      end

      return ret ? true : false
    end
  end
end
