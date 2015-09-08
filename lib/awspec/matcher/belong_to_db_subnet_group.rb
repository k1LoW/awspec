RSpec::Matchers.define :belong_to_db_subnet_group do |db_subnet_group_name|
  match do |resource|
    return true if resource.resource[:db_subnet_group][:db_subnet_group_name] == db_subnet_group_name
  end
end
