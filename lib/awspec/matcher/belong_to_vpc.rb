RSpec::Matchers.define :belong_to_vpc do |vpc_id|
  match do |resource|
    return true if resource.vpc_id == vpc_id
    ret = resource.find_vpc(vpc_id)
    return false unless ret
    ret[:vpc_id] == resource.vpc_id
  end
end
