require 'spec_helper'

Awspec::Stub.load 'ecr_repository'

describe ecr_repository('my-ecr-repository') do
  it { should exist }
  its(:registry_id) { should eq '123456789012' }
  its(:repository_name) { should eq 'my-ecr-repository' }
  its(:repository_arn) { should eq 'arn:aws:ecr:us-east-1:123456789012:repository/my-ecr-repository' }
  its(:policy_text) { should eq 'RepositoryPolicyText' }
end
