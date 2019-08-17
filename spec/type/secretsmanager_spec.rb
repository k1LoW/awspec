require 'spec_helper'
Awspec::Stub.load 'secretsmanager'

describe secretsmanager('my-secret') do
  it { should exist }
end
