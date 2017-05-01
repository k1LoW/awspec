### exist

```ruby
describe eip('123.0.456.789') do
  it { should exist }
end
```

### be_associated_to

```ruby
describe eip('123.0.456.789') do
  it { should be_associated_to('i-ec12345a') }
end
```

### belong_to_domain

```ruby
describe eip('123.0.456.789') do
  it { should belong_to_domain('vpc') }
end
```
