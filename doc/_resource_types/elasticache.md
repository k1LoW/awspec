### exist

```ruby
describe elasticache('my-rep-group-001') do
  it { should exist }
end
```

```ruby
describe elasticache('my-rep-group') do
  it { should exist }
end
```

```ruby
describe elasticache('my-serverless-cache') do
  it { should exist }
end
```

### be_available, be_creating, be_deleted, be_deleting, be_incompatible_network, be_modifying, be_rebooting_cache_cluster_nodes, be_restore_failed, be_snapshotting

```ruby
describe elasticache('my-rep-group-001') do
  it { should be_available }
end
```

### be_serverless

```ruby
describe elasticache('my-serverless-cache') do
  it { should be_serverless }
end
```

### have_cache_parameter_group

```ruby
describe elasticache('my-rep-group-001') do
  it { should have_cache_parameter_group('my-cache-parameter-group') }
end
```

```ruby
describe elasticache('my-rep-group') do
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

```ruby
describe elasticache('my-rep-group') do
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

### its(:cache_type)

```ruby
describe elasticache('my-rep-group-001') do
  its(:cache_type) { should eq 'cache_cluster' }
end
```

```ruby
describe elasticache('my-rep-group') do
  its(:cache_type) { should eq 'replication_group' }
end
```

```ruby
describe elasticache('my-serverless-cache') do
  its(:cache_type) { should eq 'serverless_cache' }
end
```

### its(:engine)

```ruby
describe elasticache('my-rep-group') do
  its(:engine) { should eq 'redis' }
end
```

### its(:engine_version)

```ruby
describe elasticache('my-rep-group') do
  its(:engine_version) { should eq '7.1' }
end
```

### its(:num_nodes)

```ruby
describe elasticache('my-rep-group') do
  its(:num_nodes) { should eq 2 }
end
```

### its(:node_count)

```ruby
describe elasticache('my-rep-group') do
  its(:node_count) { should eq 2 }
end
```

### its(:cluster_mode_enabled)

```ruby
describe elasticache('my-rep-group') do
  its(:cluster_mode_enabled) { should eq true }
end
```

### its(:serverless)

```ruby
describe elasticache('my-serverless-cache') do
  its(:serverless) { should eq true }
end
```
