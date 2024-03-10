### exist

```ruby
describe managed_prefix_list('my-managed-prefix-list') do
  it { should exist }
end
```

### have_cidr

```ruby
describe managed_prefix_list('my-managed-prefix-list') do
  it { should have_cidr('10.0.0.0/16') }
  it { should have_cidr('192.168.0.0/24').desc('dev') }
end
```

### its(:entries_count)

```ruby
describe managed_prefix_list('my-managed-prefix-list') do
  its(:entries_count) { should eq 2 }
end
```

### have_tag

```ruby
describe managed_prefix_list('my-managed-prefix-list') do
  it { should have_tag('env').value('dev') }
end
```
