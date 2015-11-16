### have_route

```ruby
describe route_table('my-route-table') do
  it { should have_route('10.0.0.0/16').target(gateway: 'local') }
  it { should have_route('0.0.0.0/0').target(gateway: 'my-igw') }
  it { should have_route('192.168.1.0/24').target(instance: 'my-instance') }
end
```
