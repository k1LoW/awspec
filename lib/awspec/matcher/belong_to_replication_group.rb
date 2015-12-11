RSpec::Matchers.define :belong_to_replication_group do |group_id|
  match do |type|
    # ElastiCache
    type.resource_via_client[:replication_group_id] == group_id
  end
end
