# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'managed_prefix_list'

describe managed_prefix_list('my-managed-prefix-list') do
  it { should exist }
  it { should have_cidr('10.0.0.0/16') }
  it { should have_cidr('192.168.0.0/24').desc('dev') }
  its(:entries_count) { should eq 2 }
  it { should have_tag('env').value('dev') }
end
