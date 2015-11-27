### exist

```ruby
describe subnet('my-subnet') do
  it { should exist }
end
```

### be_available, be_pending

```ruby
describe subnet('my-subnet') do
  it { should be_available }
end
```
