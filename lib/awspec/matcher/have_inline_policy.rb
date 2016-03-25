RSpec::Matchers.define :have_inline_policy do |policy_name|
  match do |iam_user|
    iam_user.has_inline_policy?(policy_name, @document)
  end

  chain :policy_document do |document|
    @document = document
  end
end
