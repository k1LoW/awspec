require 'thor'
require 'awspec/setup'

module Awspec
  class Generate < Thor
    types = %w(
      vpc ec2 rds security_group elb
    )

    types.each do |type|
      desc type + ' [vpc_id]', "Generate #{type} spec from VPC ID (or VPC \"Name\" tag)"
      define_method type do |*args|
        load_secrets
        vpc_id = args.first
        eval "puts Awspec::Generator::Spec::#{type.to_camel_case}.new.generate_by_vpc_id(vpc_id)"
      end
    end

    desc 'route53_hosted_zone [example.com.]', 'Generate route53_hosted_zone spec from Domain name'
    def route53_hosted_zone(hosted_zone)
      load_secrets
      puts Awspec::Generator::Spec::Route53HostedZone.new.generate_by_domain_name(hosted_zone)
    end

    no_commands do
      def load_secrets
        creds = YAML.load_file('spec/secrets.yml') if File.exist?('spec/secrets.yml')
        creds = YAML.load_file('secrets.yml') if File.exist?('secrets.yml')
        Aws.config.update({
                            region: creds['region'],
                            credentials: Aws::Credentials.new(
                              creds['aws_access_key_id'],
                              creds['aws_secret_access_key'])
                          }) if creds
      end
    end
  end
end
