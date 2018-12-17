### exist

```ruby
# launch_template_id or launch_template_name
describe launch_template('my-launch-template') do
  it { should exist }
  its(:default_version_number) { should eq 1 }
  its(:latest_version_number) { should eq 2 }
end
```

### have_tag

```ruby
describe launch_template('my-launch-template') do
  it { should have_tag('env').value('dev') }
end
```

### have_version_number

```ruby
describe launch_template('my-launch-template') do
  it { should have_version_number(2) }
end
```
