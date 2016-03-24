RSpec::Matchers.define :be_attached_to do |instance_id|
  match do |type|
    # NetworkInterface
    if type.instance_of?(Awspec::Type::NetworkInterface)
      return type.attached_to?(instance_id, @device_index)
    end
    type.attached_to?(instance_id)
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
