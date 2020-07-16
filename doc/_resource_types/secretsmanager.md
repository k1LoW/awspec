### exist

```ruby
describe secretsmanager('my-secret') do
  it { should exist }
end
```

### have_tag

```ruby
describe secretsmanager('my-secret') do
  it { should have_tag('Name').value('my-secret') }
end
```
