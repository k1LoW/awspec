Aws.config[:route53] = {
  stub_responses: {
    list_hosted_zones: {
      hosted_zones: [
        {
          id: '/hostedzone/Z1A2BCDEF34GH5',
          name: 'example.com.',
          caller_reference: '',
          resource_record_set_count: 8
        }
      ],
      marker: '',
      is_truncated: false,
      next_marker: '',
      max_items: 100
    },
    list_resource_record_sets: {
      resource_record_sets: [
        {
          name: 'example.com.',
          type: 'A',
          ttl: 3600,
          resource_records: [
            {
              value: '123.456.7.890'
            }
          ]
        },
        {
          name: 'failover.example.com.',
          type: 'A',
          ttl: 3600,
          resource_records: [
            {
              value: '123.456.7.891'
            }
          ],
          failover: 'PRIMARY'
        },
        {
          name: 'failover.example.com.',
          type: 'A',
          ttl: 3600,
          resource_records: [
            {
              value: '123.456.7.892'
            }
          ],
          failover: 'SECONDARY'
        },
        {
          name: '\052.example.com.',
          type: 'CNAME',
          ttl: 3600,
          resource_records: [
            {
              value: 'example.com'
            }
          ]
        },
        {
          name: 'example.com.',
          type: 'MX',
          ttl: 3600,
          resource_records: [
            {
              value: '10 mail.example.com'
            }
          ]
        },
        {
          name: 'mail.example.com.',
          type: 'A',
          ttl: 3600,
          resource_records: [
            {
              value: '123.456.7.890'
            }
          ]
        },
        {
          name: 'www.example.com.',
          type: 'A',
          ttl: 600,
          resource_records: [
            {
              value: '123.456.7.890'
            }
          ]
        },
        {
          name: 'example.com.',
          type: 'NS',
          ttl: 172_800,
          resource_records: [
            {
              value: 'ns-123.awsdns-45.net.'
            },
            {
              value: 'ns-6789.awsdns-01.org.'
            },
            {
              value: 'ns-2345.awsdns-67.co.uk.'
            },
            {
              value: 'ns-890.awsdns-12.com.'
            }
          ]
        },
        {
          name: 's3.example.com.',
          type: 'A',
          resource_records: [],
          alias_target: {
            hosted_zone_id: 'Z2ABCDEFGHIJKL',
            dns_name: 's3-website-us-east-1.amazonaws.com.',
            evaluate_target_health: false
          },
          failover: 'SECONDARY'
        },
        {
          name: 's3.example.com.',
          type: 'A',
          resource_records: [],
          alias_target: {
            hosted_zone_id: 'Z2FDTNDATAQYW2',
            dns_name: 'abcdefghijklmn.cloudfront.net.',
            evaluate_target_health: false
          },
          failover: 'PRIMARY'
        },
        {
          name: 'alias.example.com.',
          type: 'A',
          resource_records: [],
          alias_target: {
            hosted_zone_id: 'Z2FDTNDATAQYW2',
            dns_name: 'opqrstuvwxyz.cloudfront.net.',
            evaluate_target_health: false
          }
        },
        {
          name: 'example.com.',
          type: 'CAA',
          ttl: 600,
          resource_records: [
            {
              value: '0 issue "amazon.com"'
            },
            {
              value: '0 issue "amazontrust.com"'
            },
            {
              value: '0 issue "awstrust.com"'
            },
            {
              value: '0 issuewild "amazonaws.com"'
            },
            {
              value: '0 iodef "mailto:support@example.com"'
            }
          ]
        }
      ],
      is_truncated: false,
      max_items: 100
    }
  }
}
