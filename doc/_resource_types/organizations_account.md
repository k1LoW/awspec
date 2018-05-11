### exist

```ruby
describe organizations_account('Master Account') do
  it { should exist }
end

describe organizations_account('Member Account') do
  it { should exist }
end
```

### be_active,be_suspended

```ruby
describe organizations_account('Master Account') do
  it { should exist }
  it { should be_active }
  it { should_not be_suspended }
end
```

### be_created,be_invited

```ruby
describe organizations_account('Master Account') do
  it { should exist }
  it { should be_created }
  it { should_not be_invited }
end
```
