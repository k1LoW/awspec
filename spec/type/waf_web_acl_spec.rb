# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'waf_web_acl'

describe waf_web_acl('my-waf-web-acl') do
  it { should exist }
  its(:default_action) { should eq 'BLOCK' }
  it { should have_rule('my-waf-web-acl-allowed-ips') }
  it { should have_rule('my-waf-web-acl-allowed-ips').order(2).action('BLOCK') }
end
