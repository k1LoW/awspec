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
  its(:arn) { should be_eql('arn:aws:ssm:REGION:ACCOUNT_ID:parameter/my-parameter') }
  its(:name) { should be_eql('my-parameter') }
  its(:version) { should be_eql(1) }
end
```
