### exist

```ruby
describe rds_proxy('my-rds-proxy') do
  it { should exist }
end
```

### be_available, be_creating, be_deleting, be_incompatible_network, be_insufficient_resource_limits, be_modifying, be_reactivating, be_suspended, be_suspending

```ruby
describe rds_proxy('my-rds-proxy') do
  it { should be_available }
end
```

### have_security_group

```ruby
describe rds_proxy('my-rds-proxy') do
  it { should have_security_group('sg-5a6b7cd8') }
  it { should have_security_group('my-db-sg') }
end
```

### belong_to_subnet

```ruby
describe rds_proxy('my-rds-proxy') do
  it { should belong_to_subnet('subnet-8901b123') }
  it { should belong_to_subnet('db-subnet-a') }
end
```

### belong_to_vpc

```ruby
describe rds_proxy('my-rds-proxy') do
  it { should belong_to_vpc('vpc-ab123cde') }
  it { should belong_to_vpc('my-vpc') }
end
```
