require 'spec_helper'
Awspec::Stub.load 'elasticsearch'

describe elasticsearch('my-elasticsearch') do
  it { should exist }
  its(:elasticsearch_version) { should eq '2.3' }
  its('elasticsearch_cluster_config.instance_type') { should eq 't2.micro.elasticsearch' }
  it do
    should have_access_policies <<-policy
{
  "version": "2012-10-17",
  "statement": [
    {
      "effect": "allow",
      "principal": "*",
      "action": [
        "es:*"
      ],
      "resource": "arn:aws:es:ap-northeast-1:1234567890:domain/my-elasticsearch/*"
    }
  ]
}
  policy
  end
end
