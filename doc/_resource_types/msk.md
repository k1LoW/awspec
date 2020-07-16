### exist

```ruby
describe msk('my-msk') do
  it { should exist }
end
```

### should be_active, be_creating, be_updating, be_deleting, be_failed

```ruby
describe msk('my-msk') do
  it { should be_active }
end
```
