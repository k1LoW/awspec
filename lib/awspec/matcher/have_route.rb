RSpec::Matchers.define :have_route do |target|
  match do |route_table|
    route_table.has_route?(target, @destination)
  end

  chain :destination do |destination|
    @destination = destination
  end
end
