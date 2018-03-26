RSpec::Matchers.define :have_option_group do |name|
  match do |db_instance_identifier|
    db_instance_identifier.has_option_group?(name, @status)
  end

  chain :status do |status|
    @status = status
  end
end
