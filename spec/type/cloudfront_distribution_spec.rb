require 'spec_helper'
Awspec::Stub.load 'cloudfront_distribution'

describe cloudfront_distribution('E2CLOUDFRONTXX') do
  it { should exist }
end

describe cloudfront_distribution('123456789zyxw.cloudfront.net') do
  it { should exist }
end
