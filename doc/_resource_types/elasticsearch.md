### exist

```ruby
describe elasticsearch('my-elasticsearch') do
  it { should exist }
end
```

### be_created

```ruby
describe elasticsearch('my-elasticsearch') do
  it { should be_created }
end
```

### be_deleted

```ruby
describe elasticsearch('my-elasticsearch') do
  it { should be_deleted }
end
```

### have_access_policies

```ruby
describe elasticsearch('my-elasticsearch') do
 it do
    should have_access_policies <<-policy
{
  "version": "2012-10-17",
  "statement": [
    {
      "effect": "allow",
      "principal": "*",
      "action": [
        "es:*"
      ],
      "resource": "arn:aws:es:ap-northeast-1:1234567890:domain/my-elasticsearch/*"
    }
  ]
}
  policy
  end
end
```

