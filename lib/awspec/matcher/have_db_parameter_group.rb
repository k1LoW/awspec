RSpec::Matchers.define :have_db_parameter_group do |name|
  match do |db_instance_identifier|
    db_instance_identifier.has_db_parameter_group?(name, @parameter_apply_status)
  end

  chain :parameter_apply_status do |parameter_apply_status|
    @parameter_apply_status = parameter_apply_status
  end
end
