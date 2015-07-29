module Awspec::Type
  class Ec2 < Base
    attr_reader :client, :instance

    def initialize(id)
      super
      @client = @ec2_client
      if id.is_a?(Array)
        # Aws::EC2::Client.describe_instances native filters format
        res = @client.describe_instances({
                                           filters: id
                                         })
      elsif id.is_a?(Hash)
        # syntax sugar
        filters = []
        id.each do |k, v|
          filters.push({ name: k, values: Array(v) })
        end
        res = @client.describe_instances({
                                           filters: filters
                                         })
      else
        # instance_id or tag:Name
        begin
          res = @client.describe_instances({
                                             instance_ids: [id]
                                           })
        rescue
          # Aws::EC2::Errors::InvalidInstanceIDMalformed
          # Aws::EC2::Errors::InvalidInstanceIDNotFound
          res = @client.describe_instances({
                                             filters: [{ name: 'tag:Name', values: [id] }]
                                           })
        end
      end
      @id = res[:reservations][0][:instances][0][:instance_id]
      @instance = res[:reservations][0][:instances][0]
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
