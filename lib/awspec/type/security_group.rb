module Awspec::Type
  class SecurityGroup < Base
    aws_resource Aws::EC2::SecurityGroup

    def initialize(id)
      super
      @inbound = true
      @resource_via_client = find_security_group(id)
      @id = @resource_via_client[:group_id] if @resource_via_client
    end

    def opened?(port = nil, protocol = nil, cidr = nil)
      return inbound_opened?(port, protocol, cidr) if @inbound
      outbound_opened?(port, protocol, cidr)
    end

    def inbound_opened?(port = nil, protocol = nil, cidr = nil)
      @resource_via_client[:ip_permissions].find do |permission|
        next true unless port
        next true unless permission[:from_port]
        next true unless permission[:to_port]
        next false unless port_between?(port, permission[:from_port], permission[:to_port])
        next false if protocol && permission[:ip_protocol] != protocol
        next true unless cidr
        ret = permission[:ip_ranges].select do |ip_range|
          ip_range[:cidr_ip] == cidr
        end
        next true if ret.count > 0
        ret = permission[:user_id_group_pairs].select do |sg|
          next true if sg[:group_id] == cidr
          sg2 = find_security_group(sg[:group_id])
          next true if sg2[:group_name] == cidr
          sg2[:tags].find do |tag|
            tag[:key] == 'Name' && tag[:value] == cidr
          end
        end
        next true if ret.count > 0
      end
    end

    def outbound_opened?(port = nil, protocol = nil, cidr = nil)
      @resource_via_client[:ip_permissions_egress].find do |permission|
        next true unless port
        next true unless permission[:from_port]
        next true unless permission[:to_port]
        next false unless port_between?(port, permission[:from_port], permission[:to_port])
        next false if protocol && permission[:ip_protocol] != protocol
        next true unless cidr
        ret = permission[:ip_ranges].select do |ip_range|
          ip_range[:cidr_ip] == cidr
        end
        next true if ret.count > 0
        ret = permission[:user_id_group_pairs].select do |sg|
          next true if sg[:group_id] == cidr
          sg2 = find_security_group(sg[:group_id])
          next true if sg2[:group_name] == cidr
          sg2[:tags].find do |tag|
            tag[:key] == 'Name' && tag[:value] == cidr
          end
        end
        next true if ret.count > 0
      end
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
      @resource_via_client[:ip_permissions].count
    end
    alias_method :inbound_permissions_count, :ip_permissions_count

    def ip_permissions_egress_count
      @resource_via_client[:ip_permissions_egress].count
    end
    alias_method :outbound_permissions_count, :ip_permissions_egress_count

    def inbound_rule_count
      @resource_via_client[:ip_permissions].reduce(0) do |sum, permission|
        sum += permission.ip_ranges.count + permission.user_id_group_pairs.count
      end
    end

    def outbound_rule_count
      @resource_via_client[:ip_permissions_egress].reduce(0) do |sum, permission|
        sum += permission.ip_ranges.count + permission.user_id_group_pairs.count
      end
    end

    private

    def port_between?(port, from_port, to_port)
      if port.is_a?(String) && port.include?('-')
        f, t = port.split('-')
        from_port == f.to_i && to_port == t.to_i
      else
        port.between?(from_port, to_port)
      end
    end
  end
end
