require 'awspec/helper/color'
require 'awspec/helper/type'
require 'awspec/helper/finder'
require 'awspec/helper/credentials_loader'
extend Awspec::Helper::Type
class RSpec::Core::ExampleGroup
  extend Awspec::Helper::Type
  include Awspec::Helper::Type
end
