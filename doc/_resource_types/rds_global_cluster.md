### first

```ruby
describe rds_global_cluster('my-rds-global-cluster') do
  its(:engine) { should eq 'aurora-mysql' }
  its(:engine_version) { should eq '5.7.mysql_aurora.2.10.2' }
  its(:database_name) { should eq 'example_db' }
  its(:storage_encrypted) { should eq false }
  its(:deletion_protection) { should eq false }
end
```

### exist

```ruby
describe rds_global_cluster('my-rds-global-cluster') do
  it { should exist }
end
```

### be_available, be_creating, be_deleting

```ruby
describe rds_global_cluster('my-rds-global-cluster') do
  it { should be_available }
end
```

### have_cluster_member

```ruby
describe rds_global_cluster('my-rds-global-cluster') do
  it { should have_cluster_member('arn:aws:rds:ap-northeast-1:123456789012:cluster:my-primary-cluster') }
  it { should have_cluster_member('arn:aws:rds:ap-northeast-1:123456789012:cluster:my-primary-cluster').is_writer(true) }
  it { should have_cluster_member('arn:aws:rds:ap-northeast-3:123456789012:cluster:my-secondary-cluster').is_writer(false) }
end
```
