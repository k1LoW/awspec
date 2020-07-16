module Awspec::Type
  # rubocop:disable Metrics/ClassLength
  class SecurityGroup < ResourceBase
    aws_resource Aws::EC2::SecurityGroup
    tags_allowed

    def resource_via_client
      @resource_via_client ||= find_security_group(@display_name)
    end

    def id
      @id ||= resource_via_client.group_id if resource_via_client
    end

    def opened?(port = nil, protocol = nil, cidr = nil)
      return inbound_opened?(port, protocol, cidr) if @inbound
      outbound_opened?(port, protocol, cidr)
    end

    def opened_only?(port = nil, protocol = nil, cidr = nil)
      return inbound_opened_only?(port, protocol, cidr) if @inbound
      outbound_opened_only?(port, protocol, cidr)
    end

    def inbound_opened?(port = nil, protocol = nil, cidr = nil)
      resource_via_client.ip_permissions.find do |permission|
        cidr_opened?(permission, cidr) && protocol_opened?(permission, protocol) && port_opened?(permission, port)
      end
    end

    def inbound_opened_only?(port = nil, protocol = nil, cidr = nil)
      permissions = resource_via_client.ip_permissions.select do |permission|
        protocol_opened?(permission, protocol) && port_opened?(permission, port)
      end
      cidrs = []
      permissions.each do |permission|
        permission.ip_ranges.select { |ip_range| cidrs.push(ip_range.cidr_ip) }
      end
      cidrs == Array(cidr)
    end

    def outbound_opened?(port = nil, protocol = nil, cidr = nil)
      resource_via_client.ip_permissions_egress.find do |permission|
        cidr_opened?(permission, cidr) && protocol_opened?(permission, protocol) && port_opened?(permission, port)
      end
    end

    def outbound_opened_only?(port = nil, protocol = nil, cidr = nil)
      permissions = resource_via_client.ip_permissions_egress.select do |permission|
        protocol_opened?(permission, protocol) && port_opened?(permission, port)
      end
      cidrs = []
      permissions.each do |permission|
        permission.ip_ranges.select { |ip_range| cidrs.push(ip_range.cidr_ip) }
      end
      cidrs == Array(cidr)
    end

    def inbound
      @inbound = true
      self
    end

    def outbound
      @inbound = false
      self
    end

    def ip_permissions_count
      resource_via_client.ip_permissions.count
    end
    alias_method :inbound_permissions_count, :ip_permissions_count

    def ip_permissions_egress_count
      resource_via_client.ip_permissions_egress.count
    end
    alias_method :outbound_permissions_count, :ip_permissions_egress_count

    def has_inbound_rule?(rule)
      resource_via_client.ip_permissions.find do |permission|
        sg_rule_match?(permission, rule)
      end
    end

    def inbound_rule_count
      resource_via_client.ip_permissions.reduce(0) do |sum, permission|
        sum += permission.ip_ranges.count + permission.user_id_group_pairs.count
      end
    end

    def has_outbound_rule?(rule)
      resource_via_client.ip_permissions_egress.find do |permission|
        sg_rule_match?(permission, rule)
      end
    end

    def outbound_rule_count
      resource_via_client.ip_permissions_egress.reduce(0) do |sum, permission|
        sum += permission.ip_ranges.count + permission.user_id_group_pairs.count
      end
    end

    private

    def cidr_opened?(permission, cidr)
      return true unless cidr
      ret = permission.prefix_list_ids.select do |prefix_list_id|
        prefix_list_id.prefix_list_id == cidr
      end
      return true if ret.count > 0
      ret = permission.ip_ranges.select do |ip_range|
        # if the cidr is an IP address then do a true CIDR match
        if cidr =~ /^\d+\.\d+\.\d+\.\d+/
          net = IPAddress::IPv4.new(ip_range.cidr_ip)
          net.include?(IPAddress::IPv4.new(cidr))
        else
          ip_range.cidr_ip == cidr
        end
      end
      return true if ret.count > 0
      ret = permission.user_id_group_pairs.select do |sg|
        # Compare the sg group_name if the remote group is in another account.
        # find_security_group call doesn't return info on a remote security group.
        if !sg.user_id.nil? && (sg.user_id != resource_via_client.owner_id)
          next (sg.group_name == cidr) || (sg.group_id == cidr)
        end
        next true if sg.group_id == cidr
        sg2 = find_security_group(sg.group_id)
        next false if sg2.nil?
        next true if sg2.group_name == cidr
        sg2.tags.find do |tag|
          tag.key == 'Name' && tag.value == cidr
        end
      end
      ret.count > 0
    end

    def protocol_opened?(permission, protocol)
      return true unless protocol
      return false if protocol == 'all' && permission.ip_protocol != '-1'
      return true if permission.ip_protocol == '-1'
      permission.ip_protocol == protocol
    end

    def port_opened?(permission, port)
      return true unless port
      return true unless permission.from_port
      return true unless permission.to_port
      port_between?(port, permission.from_port, permission.to_port)
    end

    def port_between?(port, from_port, to_port)
      if port.is_a?(String) && port.include?('-')
        f, t = port.split('-')
        from_port == f.to_i && to_port == t.to_i
      else
        port.between?(from_port, to_port)
      end
    end

    def sg_rule_match?(permission, rule)
      rule[:ip_protocol] = '-1' if rule[:ip_protocol] == 'all'
      return false unless permission.ip_protocol == rule[:ip_protocol]
      return false unless permission.ip_protocol == '-1' || permission.from_port == rule[:from_port]
      return false unless permission.ip_protocol == '-1' || permission.to_port == rule[:to_port]

      if rule[:ip_range]
        return false unless permission.ip_ranges.find do |ip_range|
          ip_range.cidr_ip == rule[:ip_range]
        end
      elsif rule[:group_pair]
        return false unless permission.user_id_group_pairs.find do |pair|
          group_pair_match?(pair, rule[:group_pair])
        end
      end
      true
    end

    def group_pair_match?(actual_pair, rule_pair)
      return false unless actual_pair.group_id == rule_pair[:group_id] || rule_pair[:group_id].nil?
      return false unless actual_pair.group_name == rule_pair[:group_name] || rule_pair[:group_name].nil?
      return false unless actual_pair.user_id == rule_pair[:user_id] || rule_pair[:user_id].nil?
      return false unless actual_pair.vpc_id == rule_pair[:vpc_id] || rule_pair[:vpc_id].nil?
      return false unless
        actual_pair.vpc_peering_connection_id == rule_pair[:vpc_peering_connection_id] ||
        rule_pair[:vpc_peering_connection_id].nil?
      return false unless actual_pair.peering_status == rule_pair[:peering_status] || rule_pair[:peering_status].nil?
      true
    end
  end
  # rubocop:enable Metrics/ClassLength
end
