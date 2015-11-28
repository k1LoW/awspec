RSpec::Matchers.define :belong_to_owner do |conditions|
  match do |resource|
    owner = resource.owner
    conditions.all?{ |attr, val| owner.send(attr) == val }
  end
end
