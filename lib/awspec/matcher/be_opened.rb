# frozen_string_literal: true

DEFAULT_PROTOCOL = '-1'
DEFAULT_ROUTE = '0.0.0.0/0'

RSpec::Matchers.define :be_opened do |port|
  match do |sg|
    sg.opened?(port, @protocol, @cidr)
  end

  description do
    @protocol = DEFAULT_PROTOCOL if @protocol.nil?
    @cidr = DEFAULT_ROUTE if @cidr.nil?
    "to be opened on port #{port}, protocol \"#{@protocol}\", to/from #{@cidr}"
  end

  chain :protocol do |protocol|
    @protocol = protocol
  end

  chain :for do |cidr|
    @cidr = cidr
  end

  chain :target do |cidr|
    @cidr = cidr
  end
end
