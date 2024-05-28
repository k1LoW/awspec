### exist

```ruby
describe codebuild('my-codebuild1') do
  it { should exist }
end
```

### have_tag

```ruby
describe codebuild('my-codebuild1') do
  it { should have_tag('env').value('dev') }
end
```
