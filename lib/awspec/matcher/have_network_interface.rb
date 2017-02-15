RSpec::Matchers.define :have_network_interface do |network_interface_id|
  match do |type|
    type.has_network_interface?(network_interface_id, @device_index)
  end

  chain :device_index do |device_index|
    @device_index = device_index
  end

  (0..10).each do |idx|
    chain "as_eth#{idx}".to_sym do
      @device_index = idx
    end
  end
end
