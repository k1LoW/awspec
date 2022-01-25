# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'elastictranscoder_pipeline'

describe elastictranscoder_pipeline('my-elastictranscoder-pipeline') do
  it { should exist }
  it { should be_active }
end
