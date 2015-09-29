RSpec::Matchers.define :belong_to_metric do |name|
  match do |resource|
    if @namespace
      resource.namespace == @namespace && resource.metric_name == name
    else
      resource.metric_name == name
    end
  end

  chain :namespace do |namespace|
    @namespace = namespace
  end
end
