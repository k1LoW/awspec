### exist

```ruby
# launch_template_id or launch_template_name.
describe launch_template_version('my-launch-template') do
  it { should exist }
  its(:launch_template_name) { should eq 'my-launch-template' }
  its(:version_number) { should eq 1 }
  its(:version_description) { should eq nil }
  its(:default_version) { should eq true }
  its('launch_template_data.image_id') { should eq 'ami-12345foobar' }
  its('launch_template_data.instance_type') { should eq 't2.micro' }
end
```

#### specify version

Specify "default", "latest" or version_number.
If not specified version "default".

```ruby
# version_number
describe launch_template_version('my-launch-template:2') do
  it { should exist }
  its(:version_number) { should eq 2 }
  its(:default_version) { should eq false }
end

# latest
describe launch_template_version('my-launch-template:latest') do
  it { should exist }
  its(:version_number) { should eq 3 }
  its(:default_version) { should eq false }
end
```
