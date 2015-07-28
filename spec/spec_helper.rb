require 'awspec'
require 'yaml'
require 'pp'

Aws.config[:stub_responses] = true
Aws.config.update({
                    region: 'ap-northeast-1',
                    credentials: Aws::Credentials.new(
                      'akid',
                      'secret')
                  })

if File.exist?('spec/secrets.yml')
  creds = YAML.load_file('spec/secrets.yml')
  Aws.config.update({
                      region: creds['region'],
                      credentials: Aws::Credentials.new(
                        creds['aws_access_key_id'],
                        creds['aws_secret_access_key'])
                    })
end
