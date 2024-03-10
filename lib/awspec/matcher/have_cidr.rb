# frozen_string_literal: true

RSpec::Matchers.define :have_cidr do |cidr|
  match do |type|
    type.has_cidr?(cidr, @desc)
  end

  chain :desc do |desc|
    @desc = desc
  end
end
