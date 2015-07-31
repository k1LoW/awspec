require 'spec_helper'

Aws.config[:route53] = {
  stub_responses: {
    list_hosted_zones: {
      hosted_zones: [
        {
          id: '/hostedzone/Z1A2BCDEF34GH5',
          name: 'example.com.',
          caller_reference: '',
          resource_record_set_count: 5
        }
      ],
      marker: '',
      is_truncated: true,
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
          name: 'example.com.',
          type: 'NS',
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
          ttl: 3600,
          resource_records: [],
          alias_target: {
            hosted_zone_id: 'Z2ABCDEFGHIJKL',
            dns_name: 's3-website-us-east-1.amazonaws.com.',
            evaluate_target_health: false
          }
        }
      ],
      is_truncated: true,
      max_items: 100
    }
  }
}

describe route53_hosted_zone('example.com.') do
  it { should exist }
  its(:resource_record_set_count) { should eq 5 }
  it { should have_record_set('example.com.').a('123.456.7.890') }
  it { should have_record_set('example.com.').mx('10 mail.example.com') }
  it { should have_record_set('mail.example.com.').a('123.456.7.890').ttl(3600) }
  ns = 'ns-123.awsdns-45.net.
ns-6789.awsdns-01.org.
ns-2345.awsdns-67.co.uk.
ns-890.awsdns-12.com.'
  it { should have_record_set('example.com.').ns(ns) }
  it { should have_record_set('s3.example.com.').alias('s3-website-us-east-1.amazonaws.com.', 'Z2ABCDEFGHIJKL') }
end

describe route53_hosted_zone('Z1A2BCDEF34GH5') do
  it { should exist }
  its(:resource_record_set_count) { should eq 5 }
  it { should have_record_set('example.com.').a('123.456.7.890') }
  it { should have_record_set('example.com.').mx('10 mail.example.com') }
  it { should have_record_set('mail.example.com.').a('123.456.7.890').ttl(3600) }
  ns = 'ns-123.awsdns-45.net.
ns-6789.awsdns-01.org.
ns-2345.awsdns-67.co.uk.
ns-890.awsdns-12.com.'
  it { should have_record_set('example.com.').ns(ns) }
  it { should have_record_set('s3.example.com.').alias('s3-website-us-east-1.amazonaws.com.', 'Z2ABCDEFGHIJKL') }
end
