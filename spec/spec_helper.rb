require 'awspec'

Aws.config[:stub_responses] = true
Aws.config.update({
                    region: 'us-east-1',
                    credentials: Aws::Credentials.new(
                      'akid',
                      'secret')
                  })
