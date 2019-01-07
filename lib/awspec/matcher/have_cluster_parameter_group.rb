RSpec::Matchers.define :have_cluster_parameter_group do |name|
  match do |cluster_identifier|
    cluster_identifier.has_cluster_parameter_group?(name, @parameter_apply_status)
  end

  chain :parameter_apply_status do |parameter_apply_status|
    @parameter_apply_status = parameter_apply_status
  end
end
