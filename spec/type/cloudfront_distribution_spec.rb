require 'spec_helper'
Awspec::Stub.load 'cloudfront_distribution'

describe cloudfront_distribution('E2CLOUDFRONTXX') do
  it { should exist }
  it { should be_deployed }
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
  it do
    should have_custom_response_error_code(400)
      .error_caching_min_ttl(60)
      .response_page_path('/path/to/400.html')
      .response_code(400)
  end
  it do
    should have_custom_response_error_code(403)
      .error_caching_min_ttl(60)
      .response_page_path('/path/to/403.html')
      .response_code('403')
  end
  it do
    should have_custom_response_error_code(500)
      .error_caching_min_ttl(60)
  end
end
