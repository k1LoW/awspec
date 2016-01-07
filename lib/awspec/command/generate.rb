require 'thor'
require 'awspec/setup'

module Awspec
  class Generate < Thor
    class_option :profile

    types = %w(
      vpc ec2 rds security_group elb network_acl route_table subnet nat_gateway
    )

    types.each do |type|
      desc type + ' [vpc_id]', "Generate #{type} spec from VPC ID (or VPC \"Name\" tag)"
      define_method type do |*args|
        Awsecrets.load(options[:profile])
        vpc_id = args.first
        eval "puts Awspec::Generator::Spec::#{type.camelize}.new.generate_by_vpc_id(vpc_id)"
      end
    end

    desc 'route53_hosted_zone [example.com.]', 'Generate route53_hosted_zone spec from Domain name'
    def route53_hosted_zone(hosted_zone)
      Awsecrets.load(options[:profile])
      puts Awspec::Generator::Spec::Route53HostedZone.new.generate_by_domain_name(hosted_zone)
    end

    desc 's3_bucket [backet_name]', 'Generate s3_bucket spec from S3 bucket name. if NO args, Generate all.'
    def s3_bucket(bucket_name = nil)
      Awsecrets.load(options[:profile])
      if bucket_name
        puts Awspec::Generator::Spec::S3Bucket.new.generate(bucket_name)
      else
        puts Awspec::Generator::Spec::S3Bucket.new.generate_all
      end
    end

    types_for_generate_all = %w(
      iam_policy cloudwatch_alarm directconnect ebs
    )

    types_for_generate_all.each do |type|
      if %w(iam_policy ebs).include?(type)
        desc type, "Generate attached #{type} spec"
      else
        desc type, "Generate #{type} spec"
      end
      define_method type do
        Awsecrets.load(options[:profile])
        eval "puts Awspec::Generator::Spec::#{type.camelize}.new.generate_all"
      end
    end
  end
end
