require 'spec_helper'
Awspec::Stub.load 'cloudfront_distribution'

describe cloudfront_distribution('E2CLOUDFRONTXX') do
  it { should exist }
  it { should have_origin('cf-s3-origin-hosting.dev.example.com') }
  it { should have_origin_domain_name('cf-s3-origin-hosting.dev.example.com.s3.amazonaws.com') }
  it { should have_origin_domain_name_and_path('cf-s3-origin-hosting.dev.example.com.s3.amazonaws.com/img') }
  it do
    should have_origin('cf-s3-origin-hosting.dev.example.com')
      .domain_name('cf-s3-origin-hosting.dev.example.com.s3.amazonaws.com')
      .origin_path('/img')
      .origin_access_identity('origin-access-identity/cloudfront/E2VVVVVVVVVVVV')
  end
  it do
    should_not have_origin('cf-s3-origin-hosting.dev.example.com')
      .domain_name('cf-s3-origin-hosting.dev.example.com.s3.amazonaws.com')
      .origin_path('/tmp')
  end
end

describe cloudfront_distribution('123456789zyxw.cloudfront.net') do
  it { should exist }
end
