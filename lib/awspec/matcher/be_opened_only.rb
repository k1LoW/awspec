RSpec::Matchers.define :be_opened_only do |port|
  match do |sg|
    sg.opened_only?(port, @protocol, @cidr)
  end

  chain :protocol do |protocol|
    @protocol = protocol
  end

  chain :for do |cidr|
    @cidr = cidr
  end

  chain :target do |cidr|
    @cidr = cidr
  end
end
