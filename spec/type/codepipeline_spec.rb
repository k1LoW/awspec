# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'codepipeline'

describe codepipeline('my-codepipeline') do
  it { should exist }
  its(:name) { should eq 'my-codepipeline' }
  its(:role_arn) { should eq 'arn:aws:iam::123456789012:role/service-role/AWSCodePipelineServiceRole-my-codepipeline' }
  its('artifact_store.type') { should eq 'S3' }
  its('artifact_store.location') { should eq 'codepipeline-ap-northeast-1-12345678901' }
  its(:version) { should eq 1 }
  its(:execution_mode) { should eq 'QUEUED' }
  its(:pipeline_type) { should eq 'V2' }
end
