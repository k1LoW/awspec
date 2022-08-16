### exist

```ruby
describe rds_db_subnet_group('my-rds-db-subnet-group') do
  it { should exist }
end
```

### belong_to_subnet

```ruby
describe rds_db_subnet_group('my-rds-db-subnet-group') do
  it { should belong_to_subnet('subnet-1234a567') }
  it { should belong_to_subnet('db-subnet-a') }
end
```

### belong_to_vpc

```ruby
describe rds_db_subnet_group('my-rds-db-subnet-group') do
  it { should belong_to_vpc('vpc-ab123cde') }
  it { should belong_to_vpc('my-vpc') }
end
```
