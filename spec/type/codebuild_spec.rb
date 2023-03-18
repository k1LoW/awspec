# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'codebuild'

describe codebuild('my-codebuild1') do
  it { should exist }
end

describe codebuild('my-codebuild2') do
  it { should exist }
end
