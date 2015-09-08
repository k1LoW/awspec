RSpec::Matchers.define :belong_to_iam_group do |group_id|
  match do |resource|
    groups = resource.select_iam_group_by_user_name(resource.resource[:user_name])
    groups.find do |group|
      group.group_id == group_id || group.group_name == group_id
    end
  end
end
