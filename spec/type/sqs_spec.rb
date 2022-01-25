# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'sqs'

describe sqs('my-queue') do
  it { should exist }
  it { should have_tag('Name').value('my-queue') }
end
