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
          resource_records: [
            {
              value: '123.456.7.890'
            }
          ]
        },
        {
          name: 'example.com.',
          type: 'MX',
          resource_records: [
            {
              value: '10 mail.example.com'
            }
          ]
        },
        {
          name: 'mail.example.com.',
          type: 'A',
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
  it { should have_record_set('mail.example.com.').a('123.456.7.890') }
  ns = 'ns-123.awsdns-45.net.
ns-6789.awsdns-01.org.
ns-2345.awsdns-67.co.uk.
ns-890.awsdns-12.com.'
  it { should have_record_set('example.com.').ns(ns) }
end

describe route53_hosted_zone('Z1A2BCDEF34GH5') do
  it { should exist }
  its(:resource_record_set_count) { should eq 5 }
  it { should have_record_set('example.com.').a('123.456.7.890') }
  it { should have_record_set('example.com.').mx('10 mail.example.com') }
  it { should have_record_set('mail.example.com.').a('123.456.7.890') }
  ns = 'ns-123.awsdns-45.net.
ns-6789.awsdns-01.org.
ns-2345.awsdns-67.co.uk.
ns-890.awsdns-12.com.'
  it { should have_record_set('example.com.').ns(ns) }
end
