# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'wafregional_web_acl'

describe wafregional_web_acl('my-wafregional-web-acl') do
  it { should exist }
  its(:default_action) { should eq 'BLOCK' }
  it { should have_rule('my-wafregional-web-acl-allowed-ips') }
  it { should have_rule('my-wafregional-web-acl-allowed-ips').order(2).action('BLOCK') }
end
