### exist

```ruby
describe internet_gateway('igw-1ab2cd3e') do
  it { should exist }
end

describe internet_gateway('my-internet-gateway') do
  it { should exist }
end
```

### be_attached_to

```ruby
describe internet_gateway('igw-1ab2cd3e') do
  it { should be_attached_to('vpc-ab123cde') }
end

describe internet_gateway('igw-1ab2cd3e') do
  it { should be_attached_to('my-vpc') }
end
```

### have_tag

```ruby
describe internet_gateway('igw-1ab2cd3e') do
  it { should have_tag('Name').value('my-internet-gateway') }
end
```
