### first

```ruby
describe rds_db_cluster('my-rds-db-cluster') do
  its(:db_cluster_parameter_group) { should eq 'default.aurora-mysql5.7' }
  its(:engine) { should eq 'aurora-mysql' }
  its(:engine_version) { should eq '5.7.mysql_aurora.2.10.2' }
  its(:database_name) { should eq 'example_db' }
  its(:storage_encrypted) { should eq false }
  its(:deletion_protection) { should eq false }
end
```

### exist

```ruby
describe rds_db_cluster('my-rds-db-cluster') do
  it { should exist }
end
```

### be_available, be_creating, be_deleting

```ruby
describe rds_db_cluster('my-rds-db-cluster') do
  it { should be_available }
end
```

### have_cluster_member

```ruby
describe rds_db_cluster('my-rds-db-cluster') do
  it { should have_cluster_member('my-rds-db-cluster-instance-1') }
  it { should have_cluster_member('my-rds-db-cluster-instance-1').is_writer(true) }
  it { should have_cluster_member('my-rds-db-cluster-instance-2').is_writer(false) }
end
```

### have_security_group

```ruby
describe rds_db_cluster('my-rds-db-cluster') do
  it { should have_security_group('sg-5a6b7cd8') }
  it { should have_security_group('my-db-sg') }
end
```
