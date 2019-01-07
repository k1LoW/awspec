require 'spec_helper'
require 'awspec/error'
Awspec::Stub.load 'iam_policy'

describe iam_policy('my-iam-policy') do
  it { should exist }
  it { should be_attachable }
  its(:arn) { should eq 'arn:aws:iam::aws:policy/my-iam-policy' }
  its(:attachment_count) { should eq 1 }
  its(:policy_id) { should eq 'PABCDEFGHI123455689' }
  its(:policy_name) { should eq 'my-iam-policy' }
  it { should be_attached_to_group('my-iam-group') }
  it { should be_attached_to_user('my-iam-user') }
  it { should be_attached_to_role('HelloIAmGodRole') }
end

describe iam_policy('unknow-iam-policy') do
  it { should_not exist }
  it do
    expect { subject.attachment_count }.to raise_error(Awspec::NoExistingResource)
  end
  it do
    expect { subject.policy_id }.to raise_error(Awspec::NoExistingResource)
  end
  it do
    expect { subject.policy_name }.to raise_error(Awspec::NoExistingResource)
  end
  it do
    expect { subject.attachable? }.to raise_error(Awspec::NoExistingResource)
  end
  it do
    expect { subject.attached_to_user?('foobar') }.to raise_error(Awspec::NoExistingResource)
  end
  it do
    expect { subject.attached_to_group?('foobar') }.to raise_error(Awspec::NoExistingResource)
  end
  it do
    expect { subject.attached_to_role?('foobar') }.to raise_error(Awspec::NoExistingResource)
  end
end
