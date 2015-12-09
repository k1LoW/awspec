require 'aws-sdk'
require 'aws_config'

module Awspec::Helper
  module CredentialsLoader
    def self.load(profile = nil)
      profile = ENV['AWS_PROFILE'] if profile.nil?
      if profile
        # SharedCredentials
        aws_config = AWSConfig.profiles[profile]
        aws_config = AWSConfig.profiles['default'] unless aws_config
        Aws.config[:region] = aws_config.config_hash[:region] if aws_config
        Aws.config[:credentials] = Aws::SharedCredentials.new(profile_name: profile)
      else
        # secrets.yml
        creds = YAML.load_file('spec/secrets.yml') if File.exist?('spec/secrets.yml')
        creds = YAML.load_file('secrets.yml') if File.exist?('secrets.yml')
        return if creds.nil?
        Aws.config.update({
                            region: creds['region']
                          }) if creds.include?('region')
        Aws.config.update({
                            credentials: Aws::Credentials.new(
                              creds['aws_access_key_id'],
                              creds['aws_secret_access_key'])
                          }) if creds.include?('aws_access_key_id') && creds.include?('aws_secret_access_key')
      end
    end
  end
end
