# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'eip'

describe eip('123.0.456.789') do
  it { should exist }
  it { should be_associated_to('i-ec12345a') }
  it { should belong_to_domain('vpc') }
end
