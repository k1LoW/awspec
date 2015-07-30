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
    }
  }
}

describe route53_hosted_zone('example.com.') do
  it { should exist }
  its(:resource_record_set_count) { should eq 5 }
end

describe route53_hosted_zone('Z1A2BCDEF34GH5') do
  it { should exist }
  its(:resource_record_set_count) { should eq 5 }
end
