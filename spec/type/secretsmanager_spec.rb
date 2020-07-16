require 'spec_helper'
Awspec::Stub.load 'secretsmanager'

describe secretsmanager('my-secret') do
  it { should exist }
  it { should have_tag('key_one').value('value_one') }
end
