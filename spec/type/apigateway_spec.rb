# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'apigateway'

describe apigateway('ohx0shePof') do
  it { should exist }
  its(:id) { should eq 'ohx0shePof' }
  its(:name) { should eq 'my-apigateway' }
  its(:description) { should eq 'Zamboni is awesome' }
  its(:created_date) { should eq Time.at(1_530_826_668) }
  its(:version) { should eq 'xyzzy' }
  its(:warnings) { should eq ['Do not stop on tracks!', 'I brake for hallucinations.'] }
  its(:binary_media_types) { should eq ['*/*'] }
  its(:minimum_compression_size) { should eq 123 }
  its(:api_key_source) { should eq 'HEADER' }
  its(:policy) { should eq 'Honesty' }
  it { should have_path('/proxy') }
  it { should have_path('/zambonis') }
  it { should have_path('/zambonis/123') }
  it { should have_integration_path('/hockey') }
  it { should have_integration_path('/zambonis/{arena}') }
  it { should have_integration_path('/ListUsers') }
  it { should have_method('/zambonis', 'POST') }
  it { should have_integration_method('/zambonis/{arena}', 'POST') }
  it { should have_method('/proxy', 'GET') }
  it { should have_integration_method('/hockey', 'POST') }
  it { should have_method('/zambonis/123', 'POST') }
  it { should have_method('/zambonis/123', 'GET') }
  it { should have_integration_method('/ListUsers', 'AWS') }
  it { should have_integration_method('/SignUp', 'AWS') }
end

describe apigateway('my-apigateway') do
  it { should exist }
end
