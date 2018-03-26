### exist

```ruby
describe rds('my-rds') do
  it { should exist }
end
```

### be_available, be_backing_up, be_creating, be_deleting, be_failed, be_inaccessible_encryption_credentials, be_incompatible_credentials, be_incompatible_network, be_incompatible_option_group, be_incompatible_parameters, be_incompatible_restore, be_maintenance, be_modifying, be_rebooting, be_renaming, be_resetting_master_credentials, be_restore_error, be_storage_full, be_upgrading

```ruby
describe rds('my-rds') do
  it { should be_available }
end
```

### have_db_parameter_group

```ruby
describe rds('my-rds') do
  it { should have_db_parameter_group('my-db-parameter-group') }
  it do
    should have_db_parameter_group('custom.mysql5.6')\
      .parameter_apply_status('in-sync')
  end
end
```

### have_option_group

```ruby
describe rds('my-rds') do
  it { should have_option_group('default:mysql-5-6') }
  it do
    should have_option_group('default:mysql-5-6')\
      .status('in-sync')
  end
end
```

### have_security_group

```ruby
describe rds('my-rds') do
  it { should have_security_group('sg-5a6b7cd8') }
  it { should have_security_group('my-db-sg') }
end
```

### have_tag

```ruby
describe rds('my-rds') do
  it { should have_tag('Name').value('my-rds') }
end
```

### belong_to_db_subnet_group

```ruby
describe rds('my-rds') do
  it { should belong_to_db_subnet_group('my-db-subnet-group') }
end
```

### belong_to_subnet

```ruby
describe rds('my-rds') do
  it { should belong_to_subnet('subnet-8901b123') }
  it { should belong_to_subnet('db-subnet-a') }
end
```

### belong_to_vpc

```ruby
describe rds('my-rds') do
  it { should belong_to_vpc('vpc-ab123cde') }
  it { should belong_to_vpc('my-vpc') }
end
```

### advanced

`rds` can use `Aws::RDS::DBInstance` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/RDS/DBInstance.html).

```ruby
describe rds('my-rds') do
  its('db_subnet_group.db_subnet_group_name') { should eq 'my-db-subnet-group' }
end
```

or

```ruby
describe rds('my-rds') do
  its('resource.db_subnet_group.db_subnet_group_name') { should eq 'my-db-subnet-group' }
end
```
