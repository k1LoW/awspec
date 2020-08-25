### exist

```ruby
describe vpc_endpoints('my-vpc-endpoint') do
  it { should exist }
end
```

describe vpc_endpoints('vpce-05907f23265b25f20'), region: $tfvars["region"]["value"] do
  it { should exist }
  it { should be_available }
  it { should have_subnet('subnet-040e19eabf3226f99') }
  it { should belong_to_vpc('vpc-00af9dcc0134b48e0') }
  its(:private_dns_enabled) { should eq true }
  its(:vpc_endpoint_type) { should eq 'Interface' }
  its(:service_name) { should eq 'com.amazonaws.eu-west-1.codebuild' }
end

### be_pendingacceptance, be_pending, be_available, be_deleting, be_deleted, be_rejected, be_failed, be_expired

```ruby
describe ami('my-ami') do
  it { should be_available }
end
```

### belong_to_vpc

```ruby
describe vpc_endpoints('my-vpc-endpoint') do
  it { should belong_to_vpc('my-vpc') }
end
```

### have_route_table

```ruby
describe vpc_endpoints('my-vpc-endpoint') do
  it { should have_route_table('rtb-abc123') }
end
```

### have_subnet

```ruby
describe vpc_endpoints('my-vpc-endpoint') do
  it { should have_subnet('subnet-abc123') }
end
```

### have_tag

```ruby
describe vpc_endpoints('my-vpc-endpoint') do
  it { should have_tag('env').value('dev') }
end
```

### advanced

`vpc_endpoints` can use `Aws::EC2::Types::VpcEndpoint` resource (see https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/EC2/Types/VpcEndpoint.html).

```ruby
describe vpc_endpoints('my-vpc-endpoint') do
  its(:private_dns_enabled) { should eq true }
  its(:vpc_endpoint_type) { should eq 'Interface' }
  its(:service_name) { should eq 'com.amazonaws.eu-west-1.codebuild' }
end
```

