# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'ssm_parameter'

describe ssm_parameter('my-parameter') do
  it { should exist }
  it { should be_encrypted }
  its(:key_id) { should be_eql('alias/aws/ssm') }
  its(:description) { should be_eql('Some description') }
  its(:version) { should be_eql(1) }
end
