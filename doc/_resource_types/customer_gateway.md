### exist

```ruby
describe customer_gateway('my-customer-gateway') do
  it { should exist }
end
```

### be_pending, be_available, be_deleting, be_deleted

```ruby
describe customer_gateway('my-customer-gateway') do
  it { should be_running }
end
```

### have_tag

```ruby
describe customer_gateway('my-customer-gateway') do
  it { should have_tag('Name').value('my-customer-gateway') }
end
```

### its(:customer_gateway_id), its(:state), its(:type), its(:ip_address), its(:bgp_asn)
