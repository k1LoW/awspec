### exist

You can set launch template version ( default: $Default ).

```ruby
# launch_template_id or launch_template_name
describe launch_template('my-launch-template') do
  it { should exist }
  its(:default_version_number) { should eq 1 }
  its(:latest_version_number) { should eq 2 }
  its('launch_template_version.launch_template_data.image_id') { should eq 'ami-12345foobar' }
  its('launch_template_version.launch_template_data.instance_type') { should eq 't2.micro' }
end
```

#### specify version
 
Specify "latest" or version_number.
 
```ruby
# version_number
describe launch_template('my-launch-template'), version: 2 do
  it { should exist }
  its('launch_template_version.launch_template_data.instance_type') { should eq 't2.micro' }
end

# latest
describe launch_template('my-launch-template'), version: 'latest' do
  it { should exist }
  its('launch_template_version.launch_template_data.instance_type') { should eq 't2.micro' }
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
