### exist

```ruby
describe cloudfront_distribution('123456789zyxw.cloudfront.net') do
  it { should exist }
end
```

### have_origin

```ruby
describe cloudfront_distribution('E2CLOUDFRONTXX') do
  it do
    should have_origin('cf-s3-origin-hosting.dev.example.com')
      .domain_name('cf-s3-origin-hosting.dev.example.com.s3.amazonaws.com')
      .origin_path('/img')
      .origin_access_identity('origin-access-identity/cloudfront/E2VVVVVVVVVVVV')
  end
end
```

### have_origin_domain_name

```ruby
describe cloudfront_distribution('123456789zyxw.cloudfront.net') do
  it { should have_origin_domain_name('cf-s3-origin-hosting.dev.example.com.s3.amazonaws.com') }
end
```

### have_origin_domain_name_and_path

```ruby
describe cloudfront_distribution('123456789zyxw.cloudfront.net') do
  it { should have_origin_domain_name_and_path('cf-s3-origin-hosting.dev.example.com.s3.amazonaws.com/img') }
end
```
