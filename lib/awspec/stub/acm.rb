Aws.config[:acm] = {
  stub_responses: {
    list_certificates: {
      certificate_summary_list: [
        {
          certificate_arn: 'arn:aws:acm:region:123456789010:certificate/12345678-1234-1234-1234-123456789010',
          domain_name: 'example.com'
        }
      ]
    },
    describe_certificate: {
      certificate: {
        certificate_arn: 'arn:aws:acm:region:123456789010:certificate/12345678-1234-1234-1234-123456789010',
        domain_name: 'example.com',
        status: 'ISSUED',
        type: 'AMAZON_ISSUED'
      }
    }
  }
}
