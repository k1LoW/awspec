module Awspec::Type
  class Ec2 < Base
    attr_reader :client, :instance

    def initialize(id)
      super
      @client = @ec2_client
      @instance = find_ec2(id)
      @id = @instance[:instance_id] if @instance
    end

    states = %w(
      pending running shutting-down
      terminated stopping stopped
    )

    states.each do |state|
      define_method state + '?' do
        @instance[:state][:name] == state
      end
    end

    def method_missing(name)
      describe = name.to_s
      if @instance.key?(describe)
        @instance[describe]
      else
        super
      end
    end

    def has_eip?(ip_address = nil)
      option = {
        filters: [{ name: 'instance-id', values: [@id] }]
      }
      option[:public_ips] = [ip_address] if ip_address
      ret = @client.describe_addresses(option)
      ret[:addresses].count == 1
    end

    def has_security_group?(sg_id)
      sgs = @instance[:security_groups]
      ret = sgs.find do |sg|
        sg[:group_id] == sg_id || sg[:group_name] == sg_id
      end
      return true if ret
      sg2 = find_security_group(sg_id)
      sg2[:tags].find do |tag|
        tag[:key] == 'Name' && tag[:value] == sg_id
      end
    end
  end
end
