require 'spec_helper'
require 'stub/s3'

describe s3('my-bucket') do
  it { should exist }
  it { should have_object('path/to/object') }
end
