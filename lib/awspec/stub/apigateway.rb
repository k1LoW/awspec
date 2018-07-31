Aws.config[:apigateway] = {
  stub_responses: {
    get_rest_api: {
      id: 'my-apigateway',
      name: 'my-apigateway',
      description: 'Zamboni is awesome',
      created_date: Time.at(1_530_826_668),
      binary_media_types: [
        '*/*'
      ],
      api_key_source: 'HEADER',
      endpoint_configuration: {
        types: [
          'EDGE'
        ]
      },

      version: 'xyzzy',
      warnings: [
        'Do not stop on tracks!',
        'I brake for hallucinations.'
      ],
      minimum_compression_size: 123,
      policy: 'Honesty'
    }
  }
}
