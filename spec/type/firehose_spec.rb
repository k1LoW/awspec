# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'firehose'

describe firehose('my-firehose') do
  it { should exist }
end

describe firehose('my-firehose') do
  it { should be_active }
end

describe firehose('my-firehose') do
  its(:delivery_stream_type) { should be_eql('DirectPut') }
end

describe firehose('my-firehose') do
  it { should have_splunk_destination }
end
