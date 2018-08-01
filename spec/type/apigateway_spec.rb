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
end

describe apigateway('my-apigateway') do
  it { should exist }
end
