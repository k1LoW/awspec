RSpec::Matchers.define :have_vpc_peering_connection do |vpc_peering_connection_id|
  match do |vpc|
    vpc.has_vpc_peering_connection?(vpc_peering_connection_id, @accepter_or_requester)
  end

  chain :as_accepter do
    @accepter_or_requester = 'accepter'
  end

  chain :as_requester do
    @accepter_or_requester = 'requester'
  end
end
