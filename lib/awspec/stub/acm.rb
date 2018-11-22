Aws.config[:acm] = {
  stub_responses: {
    list_certificates: {
      certificate_summary_list: [
        {
          certificate_arn: 'arn:aws:acm:region:123456789010:certificate/12345678-1234-1234-1234-123456789000',
          domain_name: 'example.jp'
        },
        {
          certificate_arn: 'arn:aws:acm:region:123456789010:certificate/12345678-1234-1234-1234-123456789010',
          domain_name: 'example.com'
        },
        {
          certificate_arn: 'arn:aws:acm:region:123456789010:certificate/12345678-1234-1234-1234-123456789011',
          domain_name: 'example.com'
        }
      ],
      next_token: nil
    },
    describe_certificate: {
      certificate: {
        certificate_arn: 'arn:aws:acm:region:123456789010:certificate/12345678-1234-1234-1234-123456789000',
        domain_name: 'example.jp',
        status: 'ISSUED',
        type: 'AMAZON_ISSUED',
        domain_validation_options: [
          domain_name: 'example.jp',
          validation_status: 'SUCCESS',
          validation_method: 'DNS'
        ]
      }
    }
  }
}
