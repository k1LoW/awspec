RSpec::Matchers.define :belong_to_cache_subnet_group do |cache_subnet_group_name|
  match do |resource|
    return true if resource.resource[:cache_subnet_group_name] == cache_subnet_group_name
  end
end
