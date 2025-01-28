# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'wafv2_ip_set'

describe wafv2_ip_set('my-ip-set'), scope: 'REGIONAL' do
  it { should exist }
  its(:name) { should eq 'my-ip-set' }
  its(:id) { should eq '01234567-89ab-cdef-0123-456789abcdef' }
  its(:arn) do
    should eq 'arn:aws:wafv2:ap-northeast-1:123456789012:regional/ipset/'\
              'my-ip-set/01234567-89ab-cdef-0123-456789abcdef'
  end
  its(:description) { should eq 'dev ips' }
  its(:ip_address_version) { should eq 'IPV4' }
  it { should have_ip_address('10.0.0.0/32') }
  it { should have_ip_address('10.0.0.1/32') }
end
