RSpec::Matchers.define :belong_to_domain do |domain|
  match do |type|
    return true if type.resource_via_client.last[:domain] == domain
  end
end
