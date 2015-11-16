RSpec::Matchers.define :have_route do |destination|
  match do |route_table|
    @destination = destination
    route_table.has_route?(@destination, @gateway_id, @instance_id)
  end

  chain :target do |target|
    @gateway_id = target[:gateway]
    @intance_id = target[:instance]
  end

  chain :destination do |dest|
    @destination = dest
  end
end
