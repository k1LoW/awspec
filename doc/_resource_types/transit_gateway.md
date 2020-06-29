### exist

```ruby
describe transit_gateway('tgw-1234567890abcdefg') do
  it { should exist }
  it { should have_tag('Name').value('my-tgw') }
  it { should have_attachment('tgw-attach-1234567890abcdefg') }
  its('options.amazon_side_asn') { should eq 64_516 }
  its('options.auto_accept_shared_attachments') { should eq 'enable' }
  its('options.default_route_table_association') { should eq 'enable' }
  its('options.default_route_table_propagation') { should eq 'enable' }
  its('options.dns_support') { should eq 'enable' }
  its('options.vpn_ecmp_support') { should eq 'enable' }
  its('options.association_default_route_table_id') { should eq 'tgw-rtb-0123456789abcdefg' }
  its('options.propagation_default_route_table_id') { should eq 'tgw-rtb-0123456789abcdefg' }
end
```

```ruby
describe transit_gateway('my-tgw') do
  it { should exist }
  its(:transit_gateway_id) { should eq 'tgw-1234567890abcdefg' }
end
```
