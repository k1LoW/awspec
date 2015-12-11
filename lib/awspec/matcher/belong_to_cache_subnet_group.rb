RSpec::Matchers.define :belong_to_cache_subnet_group do |cache_subnet_group_name|
  match do |type|
    return true if type.resource_via_client[:cache_subnet_group_name] == cache_subnet_group_name
  end
end
