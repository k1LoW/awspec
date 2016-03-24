RSpec::Matchers.define :have_private_ip_address do |ip_address|
  match do |eni|
    eni.has_private_ip_address?(ip_address, @primary)
  end

  chain :primary do
    @primary = true
  end
end
