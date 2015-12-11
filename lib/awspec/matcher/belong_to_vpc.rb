RSpec::Matchers.define :belong_to_vpc do |vpc_id|
  match do |type|
    return true if type.vpc_id == vpc_id
    ret = type.find_vpc(vpc_id)
    return false unless ret
    ret[:vpc_id] == type.vpc_id
  end
end
