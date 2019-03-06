### exist

```ruby
describe nat_gateway('nat-7ff7777f') do
  it { should exist }
end
```

### be_pending, be_failed, be_available, be_deleting, be_deleted

```ruby
describe nat_gateway('nat-7ff7777f') do
  it { should be_available }
end
```

### have_eip

```ruby
describe nat_gateway('nat-7ff7777f') do
  it { should have_eip('123.0.456.789') }
end
```

### belong_to_vpc

```ruby
describe nat_gateway('nat-7ff7777f') do
  it { should belong_to_vpc('my-vpc') }
end
```

### have_tag

```ruby
describe nat_gateway('nat-7ff7777f') do
  it { should have_tag('Name').value('my-nat-gateway') }
end
```
