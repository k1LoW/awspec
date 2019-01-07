require 'thor'
require 'awspec/setup'

module Awspec
  class Generate < Thor
    class_option :profile
    class_option :region
    class_option :secrets_path

    types = %w(
      vpc ec2 rds security_group elb network_acl route_table subnet nat_gateway network_interface alb nlb
      internet_gateway autoscaling_group alb_listener nlb_listener redshift
    )

    types.each do |type|
      desc type + ' [vpc_id]', "Generate #{type} spec from VPC ID (or VPC \"Name\" tag)"
      define_method type do |_vpc_id|
        Awsecrets.load(profile: options[:profile], region: options[:region], secrets_path: options[:secrets_path])
        eval "puts Awspec::Generator::Spec::#{type.camelize}.new.generate_by_vpc_id(_vpc_id)"
      end
    end

    desc 'route53_hosted_zone [example.com.]', 'Generate route53_hosted_zone spec from Domain name'
    def route53_hosted_zone(hosted_zone)
      Awsecrets.load(profile: options[:profile], region: options[:region], secrets_path: options[:secrets_path])
      puts Awspec::Generator::Spec::Route53HostedZone.new.generate_by_domain_name(hosted_zone)
    end

    desc 's3_bucket [bucket_name]', 'Generate s3_bucket spec from S3 bucket name. if NO args, Generate all.'
    def s3_bucket(bucket_name = nil)
      Awsecrets.load(profile: options[:profile], region: options[:region], secrets_path: options[:secrets_path])
      if bucket_name
        puts Awspec::Generator::Spec::S3Bucket.new.generate(bucket_name)
      else
        puts Awspec::Generator::Spec::S3Bucket.new.generate_all
      end
    end

    types = %w(
      rds_db_parameter_group rds_db_cluster_parameter_group redshift_cluster_parameter_group
    )

    types.each do |type|
      desc type + ' [parameter_group_name]', "Generate #{type} spec from parameter group name."
      define_method type do |_parameter_group_name|
        Awsecrets.load(profile: options[:profile], region: options[:region], secrets_path: options[:secrets_path])
        eval "puts Awspec::Generator::Spec::#{type.camelize}.new.generate_by_parameter_group(_parameter_group_name)"
      end
    end

    types_for_generate_all = %w(
      cloudwatch_alarm cloudwatch_event directconnect ebs efs
      elasticsearch iam_group iam_policy iam_role iam_user kms lambda
      acm cloudwatch_logs eip codebuild
    )

    types_for_generate_all.each do |type|
      if %w(iam_policy ebs).include?(type)
        desc type, "Generate attached #{type} spec"
      else
        desc type, "Generate #{type} spec"
      end
      define_method type do
        Awsecrets.load(profile: options[:profile], region: options[:region], secrets_path: options[:secrets_path])
        eval "puts Awspec::Generator::Spec::#{type.camelize}.new.generate_all"
      end
    end
  end
end
