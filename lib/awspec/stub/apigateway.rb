Aws.config[:apigateway] = {
  stub_responses: {
    get_rest_api: {
      id: 'ohx0shePof',
      name: 'my-apigateway',
      description: 'Zamboni is awesome',
      created_date: Time.at(1_530_826_668),
      version: 'xyzzy',
      warnings: [
        'Do not stop on tracks!',
        'I brake for hallucinations.'
      ],
      binary_media_types: [
        '*/*'
      ],
      minimum_compression_size: 123,
      api_key_source: 'HEADER',
      policy: 'Honesty',
      endpoint_configuration: {
        types: [
          'EDGE'
        ]
      }
    },
    get_rest_apis: {
      position: '1',
      items: [
        {
          id: '111',
          name: 'first-apigateway',
          description: 'first api gateway',
          created_date: Time.at(1_444_826_668),
          version: 'plover',
          warnings: [
            'Do not take with alcohol'
          ],
          binary_media_types: [
            '*/*'
          ],
          minimum_compression_size: 456,
          api_key_source: 'HEADER',
          policy: 'Insurance',
          endpoint_configuration: {
            types: [
              'EDGE'
            ]
          }
        },
        {
          id: 'ohx0shePof',
          name: 'my-apigateway',
          description: 'Zamboni is awesome',
          created_date: Time.at(1_530_826_668),
          version: 'xyzzy',
          warnings: [
            'Do not stop on tracks!',
            'I brake for hallucinations.'
          ],
          binary_media_types: [
            '*/*'
          ],
          minimum_compression_size: 123,
          api_key_source: 'HEADER',
          policy: 'Honesty',

          endpoint_configuration: {
            types: [
              'EDGE'
            ]
          }
        }
      ]
    },
    get_resources: {
      position: '1',
      items: [
        {
          path: '/proxy',
          resource_methods: {
            'GET' => {
              http_method: 'GET',
              method_integration: { http_method: 'POST', uri: 'http://127.0.0.1:8080/hockey' }
            }
          }
        },
        {
          path: '/zambonis',
          resource_methods: {
            'POST' => {
              http_method: 'POST',
              method_integration: { http_method: 'POST',
                                    uri: 'http://127.0.0.1:8080/zambonis/{arena}?arena=Saddledome' }
            }
          }
        },
        {
          path: '/zambonis/123',
          resource_methods: {
            'POST' => {
              http_method: 'POST',
              method_integration: { http_method: 'AWS',
                                    uri: 'arn:aws:apigateway:us-east-1:cognito-idp:action/ListUsers' }
            },
            'GET' => {
              http_method: 'GET',
              method_integration: { http_method: 'AWS',
                                    uri: 'arn:aws:apigateway:us-east-1:cognito-idp:action/SignUp?username=test' }
            }
          }
        }
      ]
    }
  }
}
