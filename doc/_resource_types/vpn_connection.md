### exist

```ruby
describe vpn_connection('my-vpn-connection') do
  it { should exist }
end
```

### be_pending, be_available, be_deleting, be_deleted

```ruby
describe vpn_connection('my-vpn-connection') do
  it { should be_running }
end
```

### have_tag

```ruby
describe vpn_connection('my-vpn-connection') do
  it { should have_tag('Name').value('my-vpn-connection') }
end
```

### its(:vpn_connection_id), its(:state), its(:customer_gateway_configuration), its(:type), its(:customer_gateway_id), its(:vpn_gateway_id), its(:options)
