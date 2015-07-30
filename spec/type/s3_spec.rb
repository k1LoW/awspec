require 'spec_helper'
Aws.config[:s3] = {
  stub_responses: {
    list_buckets: {
      buckets: [
        {
          name: 'my-bucket'
        }
      ]
    },
    head_object: {
      content_type: 'binary/octet-stream'
    }
  }
}

describe s3('my-bucket') do
  it { should exist }
  it { should have_object('path/to/object') }
end
