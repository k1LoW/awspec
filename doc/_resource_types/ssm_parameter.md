### exist

```ruby
describe ssm_parameter('my-parameter') do
  it { should exist }
end
```

### be_encrypted

```ruby
describe ssm_parameter('my-parameter') do
  it { should be_encrypted }
end
```

### have_tag

```ruby
describe ssm_parameter('my-parameter') do
  it { should have_tag('my-key').value('my-value') }
end
```

### advanced

```ruby
describe ssm_parameter('my-parameter') do
  its(:key_id) { should be_eql('6a81f446-27b0-4d51-a04f-af7ddeea2e22') }
  its(:description) { should be_eql('Some string description') }
  its(:version) { should be_eql(1) }
end
```
