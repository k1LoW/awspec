### exist

```ruby
describe elasticache('my-rep-group-001') do
  it { should exist }
end
```

### be_available, be_creating, be_deleted, be_deleting, be_incompatible_network, be_modifying, be_rebooting_cache_cluster_nodes, be_restore_failed, be_snapshotting

```ruby
describe elasticache('my-rep-group-001') do
  it { should be_available }
end
```

### have_cache_parameter_group

```ruby
describe elasticache('my-rep-group-001') do
  it { should have_cache_parameter_group('my-cache-parameter-group') }
end
```

### have_security_group

```ruby
describe elasticache('my-rep-group-001') do
  it { should have_security_group('sg-da1bc2ef') }
  it { should have_security_group('group-name-sg') }
  it { should have_security_group('my-cache-sg') }
end
```

### belong_to_cache_subnet_group

```ruby
describe elasticache('my-rep-group-001') do
  it { should belong_to_cache_subnet_group('my-cache-subnet-group') }
end
```

### belong_to_replication_group

```ruby
describe elasticache('my-rep-group-001') do
  it { should belong_to_replication_group('my-rep-group') }
end
```

### belong_to_vpc

```ruby
describe elasticache('my-rep-group-001') do
  it { should belong_to_vpc('my-vpc') }
end
```
