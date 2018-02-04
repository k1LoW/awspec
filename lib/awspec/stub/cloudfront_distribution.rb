Aws.config[:cloudfront] = {
  stub_responses: {
    list_distributions: {
      distribution_list: {
        marker: '',
        next_marker: nil,
        max_items: 100,
        is_truncated: false,
        quantity: 2,
        items:
          [
            {
              id: 'E1ABCDEFG2HIJK',
              arn: 'arn:aws:cloudfront:ap-northeast-1:1234567890:alarm:my-cloudfront-1',
              status: 'Deployed',
              last_modified_time: Time.new(2015, 1, 2, 10, 00, 00, '+00:00'),
              domain_name: 'abcdefghijklmn.cloudfront.net',
              aliases: {
                quantity: 0,
                items: []
              },
              origins: {
                quantity: 1,
                items:
                  [
                    {
                      id: 'cf-s3-origin-test',
                      domain_name: 'cf-origin-test.s3.amazonaws.com',
                      origin_path: '',
                      custom_headers: {
                        quantity: 0,
                        items: []
                      },
                      s3_origin_config: {
                        origin_access_identity: ''
                      },
                      custom_origin_config: nil
                    }
                  ]
              },
              default_cache_behavior: {
                target_origin_id: 'cf-s3-origin-test',
                forwarded_values:
                  {
                    query_string: false,
                    cookies:
                      {
                        forward: 'none',
                        whitelisted_names: nil
                      },
                    headers:
                      {
                        quantity: 0,
                        items: []
                      }
                  },
                trusted_signers: {
                  enabled: false,
                  quantity: 0,
                  items: []
                },
                viewer_protocol_policy: 'allow-all',
                min_ttl: 0,
                allowed_methods: {
                  quantity: 2,
                  items: %w(HEAD GET),
                  cached_methods: {
                    quantity: 2,
                    items: %w(HEAD GET)
                  }
                },
                smooth_streaming: false,
                default_ttl: 86_400,
                max_ttl: 31_536_000,
                compress: false
              },
              cache_behaviors: {
                quantity: 0,
                items: []
              },
              custom_error_responses: {
                quantity: 0,
                items: []
              },
              comment: '',
              price_class: 'PriceClass_All',
              enabled: true,
              viewer_certificate: {
                cloud_front_default_certificate: true,
                iam_certificate_id: nil,
                acm_certificate_arn: nil,
                ssl_support_method: nil,
                minimum_protocol_version: 'SSLv3',
                certificate: nil,
                certificate_source: 'cloudfront'
              },
              restrictions: {

                geo_restriction: {

                  restriction_type: 'none',
                  quantity: 0,
                  items: []
                }
              },
              web_acl_id: '',
              http_version: 'http2',
              is_ipv6_enabled: true
            },
            {
              id: 'E2CLOUDFRONTXX',
              arn: 'arn:aws:cloudfront:ap-northeast-1:1234567890:alarm:my-cloudfront-2',
              status: 'Deployed',
              last_modified_time: Time.new(2016, 3, 2, 10, 00, 00, '+00:00'),
              domain_name: '123456789zyxw.cloudfront.net',
              aliases: {
                quantity: 1,
                items: ['cf-s3-origin-hosting.dev.example.com']
              },
              origins: {
                quantity: 1,
                items:
                  [
                    {
                      id: 'cf-s3-origin-hosting.dev.example.com',
                      domain_name: 'cf-s3-origin-hosting.dev.example.com.s3.amazonaws.com',
                      origin_path: '/img',
                      custom_headers: {
                        quantity: 0,
                        items: []
                      },
                      s3_origin_config: {
                        origin_access_identity:
                          'origin-access-identity/cloudfront/E2VVVVVVVVVVVV'
                      },
                      custom_origin_config: nil
                    }
                  ]
              },
              default_cache_behavior: {
                target_origin_id: 'cf-s3-origin-hosting.dev.example.com',
                forwarded_values: {
                  query_string: false,
                  cookies: {
                    forward: 'none',
                    whitelisted_names: nil
                  },
                  headers: {
                    quantity: 0,
                    items: []
                  }
                },
                trusted_signers: {
                  enabled: false,
                  quantity: 0,
                  items: []
                },
                viewer_protocol_policy: 'redirect-to-https',
                min_ttl: 0,
                allowed_methods: {
                  quantity: 2,
                  items: %w(HEAD GET),
                  cached_methods: {
                    quantity: 2,
                    items: %w(HEAD GET)
                  }
                },
                smooth_streaming: false,
                default_ttl: 3600,
                max_ttl: 86_400,
                compress: false
              },
              cache_behaviors: {
                quantity: 0,
                items: []
              },
              custom_error_responses: {
                quantity: 0,
                items:
                  [
                    {
                      error_code: 400,
                      response_page_path: '/path/to/400.html',
                      response_code: '400',
                      error_caching_min_ttl: 60
                    },
                    {
                      error_code: 403,
                      response_page_path: '/path/to/403.html',
                      response_code: '403',
                      error_caching_min_ttl: 60
                    },
                    {
                      error_code: 500,
                      response_page_path: '',
                      response_code: '',
                      error_caching_min_ttl: 60
                    }
                  ]
              },
              comment: 'cf-s3-origin-hosting.dev.example.com',
              price_class: 'PriceClass_200',
              enabled: true,
              viewer_certificate: {
                cloud_front_default_certificate: nil,
                iam_certificate_id: nil,
                acm_certificate_arn:
                  'arn:aws:acm:us-east-1:012345678900:certificate/e1234e56-abcd-1234-5c6e-789ca0123d4b',
                ssl_support_method: 'sni-only',
                minimum_protocol_version: 'TLSv1',
                certificate:
                  'arn:aws:acm:us-east-1:012345678900:certificate/e1234e56-abcd-1234-5c6e-789ca0123d4b',
                certificate_source: 'acm'
              },
              restrictions: {
                geo_restriction: {
                  restriction_type: 'none',
                  quantity: 0,
                  items: []
                }
              },
              web_acl_id: '',
              http_version: 'http1.1',
              is_ipv6_enabled: true
            }
          ]
      }
    }
  }
}
