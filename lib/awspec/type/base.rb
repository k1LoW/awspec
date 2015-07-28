require 'aws-sdk'

module Awspec::Type
  class Base
    attr_reader :id, :ec2_client

    def initialize(id = nil)
      @tmp = id
      @ec2_client = Aws::EC2::Client.new
    end

    def to_s
      type = self.class.name.split(':')[-1]
      type.gsub!(/([a-z\d])([A-Z])/, '\1 \2')
      type.capitalize!
      %Q!#{type} "#{@id}"!
    end

    def inspect
      if defined?(PowerAssert)
        @inspection
      else
        to_s
      end
    end

    def to_ary
      to_s.split(' ')
    end

    def find_security_group(id)
      res = @ec2_client.describe_security_groups({
                                                   filters: [{ name: 'group-id', values: [id] }]
                                                 })

      return res[:security_groups][0] if res[:security_groups].count == 1
      res = @ec2_client.describe_security_groups({
                                                   filters: [{ name: 'group-name', values: [id] }]
                                                 })

      return res[:security_groups][0] if res[:security_groups].count == 1
      res = @ec2_client.describe_security_groups({
                                                   filters: [{ name: 'tag:Name', values: [id] }]
                                                 })

      return res[:security_groups][0] if res[:security_groups].count == 1
    end
  end
end
