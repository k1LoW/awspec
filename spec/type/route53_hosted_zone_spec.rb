require 'spec_helper'

Aws.config[:route53] = {
  stub_responses: {
    list_hosted_zones: {
      hosted_zones: [
        {
          id: '/hostedzone/Z1A2BCDEF34GH5',
          name: 'example.com.',
          caller_reference: ''
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
end

describe route53_hosted_zone('Z1A2BCDEF34GH5') do
  it { should exist }
end
