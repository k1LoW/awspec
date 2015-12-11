RSpec::Matchers.define :belong_to_metric do |name|
  match do |type|
    if @namespace
      type.namespace == @namespace && type.metric_name == name
    else
      type.metric_name == name
    end
  end

  chain :namespace do |namespace|
    @namespace = namespace
  end
end
