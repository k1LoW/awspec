### first

```ruby
describe rds_db_cluster_parameter_group('my-rds-db-cluster-parameter-group') do
  its(:time_zone) { should eq 'US/Central' }
  its(:binlog_format) { should eq 'ROW' }
  its(:character_set_server) { should eq 'utf8mb4' }
end
```
### exist

```ruby
describe rds_db_cluster_parameter_group('my-rds-db-cluster-parameter-group') do
  it { should exist }
end
```
