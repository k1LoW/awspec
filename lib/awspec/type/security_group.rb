module Awspec::Type
  class SecurityGroup < Base
    attr_reader :client

    def initialize(id)
      super
      @client = @ec2_client
      @inbound = true
      @resource = find_security_group(id)
      @id = @resource[:group_id] if @resource
    end

    def opened?(port = nil, protocol = nil, cidr = nil)
      if @inbound
        return inbound_opened?(port, protocol, cidr)
      else
        return outbound_opened?(port, protocol, cidr)
      end
    end

    def inbound_opened?(port = nil, protocol = nil, cidr = nil)
      @resource[:ip_permissions].find do |permission|
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
      @resource[:ip_permissions_egress].find do |permission|
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
      @resource[:ip_permissions].count
    end
    alias_method :inbound_permissions_count, :ip_permissions_count

    def ip_permissions_egress_count
      @resource[:ip_permissions_egress].count
    end
    alias_method :outbound_permissions_count, :ip_permissions_egress_count

    private

    def port_between?(port, from_port, to_port)
      if port.is_a?(String) && port.include?('-')
        f, t = port.split('-')
        return false unless from_port == f.to_i && to_port == t.to_i
      else
        return false unless port.between?(from_port, to_port)
      end
      true
    end
  end
end
