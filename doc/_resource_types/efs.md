### exist

```ruby
describe efs('my-efs') do
  it { should exist }
end
```

### have_tag

```ruby
describe efs('my-efs') do
  it { should have_tag('my-key').value('my-value') }
end
```
