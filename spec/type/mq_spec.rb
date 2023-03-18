# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'mq'

describe mq('my-mq') do
  it { should exist }
  it { should be_running }
  it { should have_security_group('sg-788eab237e47f1472') }
  it { should have_security_group('mq-group-name-sg') }
  it { should have_security_group('my-mq-sg') }
  it { should have_tag('Name').value('my-mq') }
end
