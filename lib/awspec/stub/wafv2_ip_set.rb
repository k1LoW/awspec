# frozen_string_literal: true

Aws.config[:wafv2] = {
  stub_responses: {
    get_ip_set: {
      ip_set: {
        name: 'my-wafv2-ip-set',
        id: '01234567-89ab-cdef-0123-456789abcdef',
        arn: 'arn:aws:wafv2:ap-northeast-1:123456789012:regional/ipset/'\
             'my-wafv2-ip-set/01234567-89ab-cdef-0123-456789abcdef',
        description: 'dev ips',
        ip_address_version: 'IPV4',
        addresses: [
          '10.0.0.0/32',
          '10.0.0.1/32'
        ]
      },
      lock_token: '01234567-89ab-cdef-0123456789abcdef0'
    },
    list_ip_sets: {
      next_marker: 'my-wafv2-ip-set',
      ip_sets: [
        {
          name: 'my-wafv2-ip-set',
          id: '01234567-89ab-cdef-0123-456789abcdef',
          description: 'dev ips',
          lock_token: '01234567-89ab-cdef-0123456789abcdef0',
          arn: 'arn:aws:wafv2:ap-northeast-1:123456789012:regional/ipset/'\
               'my-wafv2-ip-set/01234567-89ab-cdef-0123-456789abcdef'
        }
      ]
    }
  }
}
