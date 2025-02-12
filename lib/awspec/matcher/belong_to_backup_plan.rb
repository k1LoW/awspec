RSpec::Matchers.define :belong_to_backup_plan do |plan|
    match do |type|
      return true if type.backup_plan_id == plan

      ret = type.find_backup_plan(plan)
      return false unless ret

      type.backup_plan_id == (ret.backup_plan_id)
    end
  end
