### exist

```ruby
describe redshift('my-redshift') do
  it { should exist }
end
```

### be_available, be_cancelling_resize, be_creating, be_deleting, be_final_snapshot, be_hardware_failure, be_incompatible_hsm, be_incompatible_network, be_incompatible_parameters, be_incompatible_restore, be_modifying, be_rebooting, be_renaming, be_resizing, be_rotating_keys, be_storage_full, be_updating_hsm

```ruby
describe redshift('my-redshift') do
  it { should be_available }
end
```

### have_cluster_parameter_group

```ruby
describe redshift('my-redshift') do
  it { should have_cluster_parameter_group('my-pg') }
  it do
    should have_cluster_parameter_group('my-pg')\
      .parameter_apply_status('in-sync')
  end
end
```

### have_security_group

```ruby
describe redshift('my-redshift') do
  it { should have_security_group('sg-1a2b3c4d') }
  it { should have_security_group('group-name-sg') }
end
```

### have_tag

```ruby
describe redshift('my-redshift') do
  it { should have_tag('Name').value('my-cluster') }
end
```

### belong_to_cluster_subnet_group

```ruby
describe redshift('my-redshift') do
  it { should belong_to_cluster_subnet_group('my-sg') }
end
```

### belong_to_vpc

```ruby
describe redshift('my-redshift') do
  it { should belong_to_vpc('vpc-ab123cde') }
  it { should belong_to_vpc('my-vpc') }
end
```
