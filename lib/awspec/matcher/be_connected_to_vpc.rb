RSpec::Matchers.define :be_connected_to_vpc do |vpc_id|
  match do |vpc|
    vpc.connected_to_vpc?(vpc_id, @accepter_or_requester)
  end

  chain :as_accepter do
    @accepter_or_requester = 'accepter'
  end

  chain :as_requester do
    @accepter_or_requester = 'requester'
  end
end
