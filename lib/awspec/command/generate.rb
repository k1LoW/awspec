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
        eval "puts Awspec::Generator::Spec::#{type.camelize}.new.generate_by_vpc_id(vpc_id)"
      end
    end

    types_for_generate_all = %w(
      iam_policy cloudwatch_alarm
    )

    desc 'route53_hosted_zone [example.com.]', 'Generate route53_hosted_zone spec from Domain name'
    def route53_hosted_zone(hosted_zone)
      load_secrets
      puts Awspec::Generator::Spec::Route53HostedZone.new.generate_by_domain_name(hosted_zone)
    end

    types_for_generate_all = %w(
      iam_policy cloudwatch_alarm
    )

    types_for_generate_all.each do |type|
      if type == 'iam_policy'
        desc 'iam_policy', 'Generate attached iam_policy spec'
      else
        desc type, "Generate #{type} spec"
      end
      define_method type do
        load_secrets
        eval "puts Awspec::Generator::Spec::#{type.camelize}.new.generate_all"
      end
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
