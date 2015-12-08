require 'aws-sdk'
require 'aws_config'

module Awspec::Helper
  module CredentialsLoader
    def self.load(profile = nil)
      profile = ENV['AWS_PROFILE'] if profile.nil?
      role_profile = ENV['IAM_PROFILE'] if role_profile.nil?
      if profile
        # SharedCredentials
        aws_config = AWSConfig.profiles[profile]
        aws_config = AWSConfig.profiles['default'] unless aws_config
        Aws.config[:region] = aws_config.config_hash[:region] if aws_config
        Aws.config[:credentials] = Aws::SharedCredentials.new(profile_name: profile)
      # else
      elsif profile.nil? && role_profile.nil?
        # secrets.yml
        creds = YAML.load_file('spec/secrets.yml') if File.exist?('spec/secrets.yml')
        creds = YAML.load_file('secrets.yml') if File.exist?('secrets.yml')
        Aws.config.update({
                            region: creds['region'],
                            credentials: Aws::Credentials.new(
                              creds['aws_access_key_id'],
                              creds['aws_secret_access_key'])
                          }) if creds
      elsif role_profile == 'true' && profile.nil?
        creds = YAML.load_file('spec/secrets.yml') if File.exist?('spec/secrets.yml')
        creds = YAML.load_file('secrets.yml') if File.exist?('secrets.yml')
        Aws.config.update({
                            region: creds['region']
                          }) if creds
      else
        STDERR.puts 'You need set any credentials'
      end
    end
  end
end
