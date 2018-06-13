require 'spec_helper'
Awspec::Stub.load 'firehose'

describe firehose('my-firehose') do
  it { should exist }
end

describe firehose('my-firehose') do
  it { should be_active }
end
