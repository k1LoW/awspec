require 'thor'
require 'awspec/setup'
require 'awspec/helper/credentials_loader'

module Awspec
  class Generate < Thor
    class_option :profile

    types = %w(
      vpc ec2 rds security_group elb network_acl
    )

    types.each do |type|
      desc type + ' [vpc_id]', "Generate #{type} spec from VPC ID (or VPC \"Name\" tag)"
      define_method type do |*args|
        Awspec::Helper::CredentialsLoader.load(options[:profile])
        vpc_id = args.first
        eval "puts Awspec::Generator::Spec::#{type.camelize}.new.generate_by_vpc_id(vpc_id)"
      end
    end

    desc 'route53_hosted_zone [example.com.]', 'Generate route53_hosted_zone spec from Domain name'
    def route53_hosted_zone(hosted_zone)
      Awspec::Helper::CredentialsLoader.load(options[:profile])
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
        Awspec::Helper::CredentialsLoader.load(options[:profile])
        eval "puts Awspec::Generator::Spec::#{type.camelize}.new.generate_all"
      end
    end
  end
end
