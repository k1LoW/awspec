RSpec::Matchers.define :have_attribute_definition do |attribute_name|
  match do |attribute|
    attribute.has_attribute_definition?(attribute_name, @attribute_type)
  end

  chain :attribute_type do |type|
    @attribute_type = type
  end
end
