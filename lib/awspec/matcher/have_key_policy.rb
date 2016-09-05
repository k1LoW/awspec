RSpec::Matchers.define :have_key_policy do |policy_name|
  match do |key_type|
    key_type.has_key_policy?(policy_name, @document)
  end

  chain :policy_document do |document|
    @document = document
  end
end
