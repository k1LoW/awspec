# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'codedeploy'

describe codedeploy('my-codedeploy') do
  it { should exist }
  its(:application_id) { should eq 'd3be67e5-e7l6-457b-946b-7a457EXAMPLE' }
  its(:application_name) { should eq 'my-codedeploy' }
  its(:create_time) { should eq Time.at(1_446_229_001) }
  its(:linked_to_git_hub) { should eq false }
end
