require 'ipaddr'

RSpec::Matchers.define :have_route do |destination|
  match do |route_table|
    if !is_ipaddr?(destination) && @use_destination
      @gateway_id = destination
    else
      @destination = destination
    end
    route_table.has_route?(@destination, @gateway_id, @instance_id)
  end

  chain :target do |target|
    @gateway_id = target[:gateway]
    @intance_id = target[:instance]
  end

  chain :destination do |dest|
    puts '!!! `destination is deprecated. see https://github.com/k1LoW/awspec/pull/65 !!!'
    @use_destination = true
    @destination = dest
  end

  private

  def is_ipaddr?(str)
    IPAddr.new(str)
  rescue
    false
  end
end
