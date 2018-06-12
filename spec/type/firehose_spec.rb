require 'spec_helper'
Awspec::Stub.load 'firehose'

describe firehose('my-firehose') do
  it { should exist }
end
