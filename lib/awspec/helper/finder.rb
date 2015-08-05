require 'aws-sdk'
require 'awspec/helper/finder/vpc'
require 'awspec/helper/finder/ec2'
require 'awspec/helper/finder/security_group'
require 'awspec/helper/finder/rds'
require 'awspec/helper/finder/route53'
require 'awspec/helper/finder/s3'

module Awspec::Helper
  module Finder
    attr_reader :ec2_client
    include Awspec::Helper::Finder::Vpc
    include Awspec::Helper::Finder::Ec2
    include Awspec::Helper::Finder::SecurityGroup
    include Awspec::Helper::Finder::Rds
    include Awspec::Helper::Finder::Route53
    include Awspec::Helper::Finder::S3

    # rubocop:disable all
    def initialize(id = nil)
      @ec2_client = Aws::EC2::Client.new
      @rds_client = Aws::RDS::Client.new
      @route53_client = Aws::Route53::Client.new
      @s3_client = Aws::S3::Client.new
    end
  end
end
