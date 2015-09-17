RSpec::Matchers.define :belong_to_replication_group do |group_id|
  match do |resource|
    # ElastiCache
    resource.resource[:replication_group_id] == group_id
  end
end
