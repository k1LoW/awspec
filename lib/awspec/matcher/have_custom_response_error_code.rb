RSpec::Matchers.define :have_custom_response_error_code do |error_code|
  match do |cloudfront_distribution|
    cloudfront_distribution.has_custom_response_error_code?(error_code,
                                                            response_page_path: @response_page_path,
                                                            response_code: @response_code,
                                                            error_caching_min_ttl: @error_caching_min_ttl
                                                           )
  end

  chain :response_page_path do |response_page_path|
    @response_page_path = response_page_path
  end

  chain :response_code do |response_code|
    @response_code = response_code
  end

  chain :error_caching_min_ttl do |error_caching_min_ttl|
    @error_caching_min_ttl = error_caching_min_ttl
  end
end
