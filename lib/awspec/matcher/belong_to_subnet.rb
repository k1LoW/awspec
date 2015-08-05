RSpec::Matchers.define :belong_to_subnet do |subnet_id|
  match do |resource|
    # EC2
    if resource.instance_of?(Awspec::Type::Ec2)
      return true if resource.subnet_id == subnet_id
      subnet = resource.find_subnet(subnet_id)
      return false unless subnet
      return subnet[:subnet_id] == resource.subnet_id
    end

    # RDS
    if resource.instance_of?(Awspec::Type::Rds)
      subnets = resource.instance[:db_subnet_group][:subnets]
      ret = subnets.find do |s|
        s[:subnet_identifier] == subnet_id
      end

      return ret[:subnet_availability_zone][:name] == resource.availability_zone if ret

      res = resource.ec2_client.describe_subnets({
                                                   filters: [{ name: 'tag:Name', values: [subnet_id] }]
                                                 })
      return false unless res
      ret = subnets.find do |s|
        s[:subnet_identifier] == res[:subnets][0][:subnet_id]
      end

      return ret[:subnet_availability_zone][:name] == resource.availability_zone if ret
    end
  end
end
