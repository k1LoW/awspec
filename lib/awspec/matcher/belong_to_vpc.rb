RSpec::Matchers.define :belong_to_vpc do |vpc_id|
  match do |resource|
    return true if resource.vpc_id == vpc_id
    ret = resource.ec2_client.describe_vpcs({
                                              filters: [{ name: 'tag:Name', values: [vpc_id] }]
                                            })
    return false unless ret
    ret[:vpcs][0][:vpc_id] == resource.vpc_id
  end
end
