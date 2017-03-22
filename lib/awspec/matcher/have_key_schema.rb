RSpec::Matchers.define :have_key_schema do |attribute_name|
  match do |attribute|
    attribute.has_key_schema?(attribute_name, @key_type)
  end

  chain :key_type do |type|
    @key_type = type
  end
end
