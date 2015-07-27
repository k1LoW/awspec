module Awspec::Type
  class Ec2 < Base
    attr_reader :client, :instance

    def initialize(id)
      super(id)
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
          filters.push({
                         name: k,
                         values: Array(v)
                       })
        end
        res = @client.describe_instances({
                                           filters: filters
                                         })
      else
        # instance_id
        res = @client.describe_instances({
                                           instance_ids: [@id]
                                         })
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

    describes = %w(
      instance_id image_id state private_dns_name public_dns_name
      state_transition_reason key_name ami_launch_index product_codes
      instance_type launch_time placement kernel_id ramdisk_id platform
      monitoring subnet_id vpc_id private_ip_address public_ip_address
      state_reason architecture root_device_type root_device_name
      block_device_mappings virtualization_type instance_lifecycle
      spot_instance_request_id client_token tags security_groups
      source_dest_check hypervisor network_interfaces
      iam_instance_profile ebs_optimized sriov_net_support
    )

    describes.each do |describe|
      define_method describe do
        @instance[describe]
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
