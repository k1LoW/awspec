require 'spec_helper'
Awspec::Stub.load 'firehose'

describe firehose('my-firehose') do
  it { should exist }
end

describe firehose('my-firehose') do
  it { should be_active }
end

describe firehose('my-firehose') do
  it { should have_source_type('DirectPut') }
end

describe firehose('my-firehose') do
  it { should have_splunk_destination }
end
