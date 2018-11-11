### exist

```ruby
describe ec2('my-ec2') do
  it { should exist }
end
```

### be_disabled_api_termination

```ruby
describe ec2('my-ec2') do
  it { should be_disabled_api_termination }
end
```

### be_pending, be_running, be_shutting_down, be_terminated, be_stopping, be_stopped

```ruby
describe ec2('my-ec2') do
  it { should be_running }
end
```

### have_classiclink

```ruby
describe ec2('my-ec2-classic') do
  it { should have_classiclink('my-vpc') }
end
```

### have_classiclink_security_group

```ruby
describe ec2('my-ec2-classic') do
  it { should have_classiclink_security_group('sg-2a3b4cd5') }
  it { should have_classiclink_security_group('my-vpc-security-group-name') }
end
```

### have_credit_specification

The credit option for CPU usage of T2 or T3 instance.

```ruby
describe ec2('my-ec2') do
  it { should have_credit_specification('unlimited') }
end
```

### have_ebs

```ruby
describe ec2('my-ec2') do
  it { should have_ebs('vol-123a123b') }
  it { should have_ebs('my-volume') }
end
```

### have_eip

```ruby
describe ec2('my-ec2') do
  it { should have_eip('123.0.456.789') }
end
```

### have_event

```ruby
describe ec2('my-ec2') do
  it { should have_event('system-reboot') }
end
```

### have_events

```ruby
describe ec2('my-ec2') do
  it { should_not have_events }
end
```

### have_network_interface

```ruby
describe ec2('my-ec2') do
  it { should have_network_interface('my-eni') }
  it { should have_network_interface('eni-12ab3cde') }
  it { should have_network_interface('my-eni').as_eth0 }
end
```

### have_security_group

```ruby
describe ec2('my-ec2') do
  it { should have_security_group('my-security-group-name') }
  it { should have_security_group('sg-1a2b3cd4') }
end
```

### have_security_groups

```ruby
describe ec2('my-ec2') do
  it { should have_security_groups(['my-security-group-name-1', 'my-security-group-name-2']) }
  it { should have_security_groups(['sg-1a2b3cd4', 'sg-5e6f7gh8']) }
end
```

### have_tag

```ruby
describe ec2('my-ec2') do
  it { should have_tag('Name').value('my-ec2') }
end
```

### belong_to_subnet

```ruby
describe ec2('my-ec2') do
  it { should belong_to_subnet('subnet-1234a567') }
  it { should belong_to_subnet('my-subnet') }
end
```

### belong_to_vpc

```ruby
describe ec2('my-ec2') do
  it { should belong_to_vpc('vpc-ab123cde') }
  it { should belong_to_vpc('my-vpc') }
end
```

### have_iam_instance_profile

```ruby
describe ec2('my-ec2') do
  it { should have_iam_instance_profile('Ec2IamProfileName') }
end
```

### advanced

`ec2` can use `Aws::EC2::Instance` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/Instance.html).

```ruby
describe ec2('my-ec2') do
  its('vpc.id') { should eq 'vpc-ab123cde' }
end
```

or

```ruby
describe ec2('my-ec2') do
  its('resource.vpc.id') { should eq 'vpc-ab123cde' }
end
```

#### Awspec::DuplicatedResourceTypeError exception

EC2 resources might have the same tag value and if you try to search for a
specific instance using that tag/tag value you might found multiples results
and receive a `Awspec::DuplicatedResourceTypeError` exception as result.

To avoid such situations, you will want to use EC2 instances ID's and then use
those ID's to test whatever you need.

There are several different ways to provide such ID's, like using [Terraform output](https://www.terraform.io/docs/configuration/outputs.html) or even the
AWS SDK directly:

```ruby
require 'awspec'
require 'aws-sdk-ec2'

tag_name = 'tag:Name'
tag_value = 'foobar'
servers = {}
ec2 = Aws::EC2::Resource.new
ec2.instances({filters: [{name: "#{tag_name}",
                          values: ["#{tag_value}"]}]}).each do |i|
  servers.store(i.id, i.subnet_id)
end

if servers.size == 0
  raise "Could not find any EC2 instance with #{tag_name} = #{tag_value}!"
end

servers.each_pair do |instance_id, subnet_id|
  describe ec2(instance_id) do
    it { should exist }
    it { should be_running }
    its(:image_id) { should eq 'ami-12345foobar' }
    its(:instance_type) { should eq 't2.micro' }
    it { should belong_to_subnet(subnet_id) }
  end
end
```
