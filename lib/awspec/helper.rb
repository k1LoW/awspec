require 'awspec/helper/type'
extend Awspec::Helper::Type
class RSpec::Core::ExampleGroup
  extend Awspec::Helper::Type
  include Awspec::Helper::Type
end
