# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'transfer_server'

describe transfer_server('s-4dc0a424f0154fa89') do
  it { should exist }
  it { should be_online }
  it { should have_tag('env').value('dev') }
  it { should have_tag('Name').value('my-transfer-server') }
  its(:user_count) { should eq(13) }
end

describe transfer_server('my-transfer-server') do
  it { should exist }
end
